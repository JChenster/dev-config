# portable aliases for bash and other applications (like vim)
shopt -s expand_aliases

# ******************************************************************************
# grep magic
# ******************************************************************************

# print file name in yellow, line number in cyan, and num matches
function fmt_grep() {
    matches=0
    while read -r line; do
        echo $line | awk -F: '{printf "\033[1;33m" $1 ":";
            printf "\033[1;36m" $2 "\033[0m";
            for(i=3;i<=NF;i++){out=out":"$i};
            print out}'
        matches=$((matches + 1))
    done
    echo "$Green$matches MATCHES$Color_Off"
}

# print number of matches per file
function fmt_match_count() {
    query=$1

    files=""
    matches=0
    while read -r line; do
        files+=" ${line%%:*}"
        matches=$((matches + 1))
    done

    cmd="grep -c $query $files | uniq"
    eval $cmd | awk -F: '{printf "\033[33m" $1 ": \033[32m" $2 " MATCHES\n"}'
    num_files=$(eval $cmd | wc -l | awk '{print $1}')
    echo "${Cyan}$matches MATCHES ACROSS $num_files FILES$Color_Off"
}

# exclude wacky dirs
GREP_EXCLUDE_DIRS=".git"
GREP_EXCLUDE_FILES="tags"
GREP_EXCLUDE_FLAGS=""

function gen_grep_exclude_flags() {
    GREP_EXCLUDE_FLAGS=""
    for dir in $GREP_EXCLUDE_DIRS
    do
        GREP_EXCLUDE_FLAGS+=" --exclude-dir=$dir"
    done
    for f in $GREP_EXCLUDE_FILES
    do
        GREP_EXCLUDE_FLAGS+=" --exclude=$f"
    done
}

function grep_helper() {
    path=$1
    flags=$2
    fmt_func=$3
    shift
    shift
    shift

    gen_grep_exclude_flags
    cmd="grep $flags $GREP_EXCLUDE_FLAGS --color=always"
    cmd+=" \"$@\" $path"
    echo "$cmd"
    eval $cmd | $fmt_func $query
}

# general purpose search
function gr() {
    grep_helper . -nrI fmt_grep "$@"
}

# search number of matches per file
function grf() {
    query=$1
    grep_helper . -nrI fmt_match_count "$@"
}

# search on a file
function gf() {
    file=$1
    shift
    grep_helper $file -nrI fmt_grep "$@"
}
