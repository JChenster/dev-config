# COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# allow escaped chars
alias echo="echo -e"

function color() {
    col=$1
    IFS="\n"
    while read -r line; do
        echo "${col}${line}"
    done
}

# rm safety
alias rm="rm -i"

# editing zsh config
ZSHRC=~/.zshrc
function src() {
    source $ZSHRC
    echo "Sourced $ZSHRC" | color $Yellow
}
alias ezsh="vim $ZSHRC"

# vim config
alias v="vim"
alias evim="vim ~/.vimrc"

# tmux config
alias emux="vim ~/.tmux.conf"
alias smux="tmux source-file ~/.tmux.conf"

# crtl + right to go forwards a word, crtl + left to go backwards
bindkey "5C" forward-word
bindkey "5D" backward-word

# grep magic
function fmt_grep() {
    IFS="\n"
    matches=0
    while read -r line; do
        echo $line | awk -F: '{printf "\033[1;33m" $1 ":";
            printf "\033[1;36m" $2 "\033[0m";
            for(i=3;i<=NF;i++){out=out":"$i};
            print out}'
        matches=$((matches + 1))
    done
    echo "$Green$matches MATCHES"
}

function fmt_match_count() {
    query=$1

    IFS="\n"
    files=""
    matches=0
    while read -r line; do
        files+=" ${line%%:*}"
        matches=$((matches + 1))
    done

    cmd="grep -c $query $files | uniq"
    eval $cmd | awk -F: '{printf "\033[33m" $1 ": \033[32m" $2 " MATCHES\n"}'
    num_files=$(eval $cmd | wc -l | awk '{print $1}')
    echo "${Cyan}$matches MATCHES ACROSS $num_files FILES"
}

GREP_EXCLUDE_DIRS=(".git")
GREP_EXCLUDE_FLAGS=""

function gen_grep_exclude_flags() {
    GREP_EXCLUDE_FLAGS=""
    for dir in "${GREP_EXCLUDE_DIRS[*]}"; do
        GREP_EXCLUDE_FLAGS+=" --exclude-dir=$dir"
    done
}

function grep_helper() {
    flags=$1
    query=$2
    fmt_func=$3

    gen_grep_exclude_flags
    cmd=""
    cmd="grep $flags $GREP_EXCLUDE_FLAGS --color=always"
    cmd+=" $query ."
    eval $cmd | $fmt_func $query
}

# general purpose search
function gr() {
    query=$1
    grep_helper -nrI $query fmt_grep
}

# search number of matches per file
function grf() {
    query=$1
    grep_helper -nrI $query fmt_match_count
}

# list files with trailing whitespace
function fws() {
    echo "Files with trailing whitespace:" | color $Red
    gen_grep_exclude_flags
    eval "grep -rlI $GREP_EXCLUDE_FLAGS '[[:blank:]]$' ." | color $Yellow
}
