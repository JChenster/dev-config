# ******************************************************************************
# cli aliases
# ******************************************************************************

# allow escaped chars
alias echo="echo -e"

# ls stuff
# show dirs in cyan, executables in red
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
# show . files
alias ls="ls -a -G"

# safety
alias rm="rm -i"
alias cp="cp -i"

# rm a lot of files with double confirmation
function big_rm() {
    echo "${Red}These files will be deleted:${Color_Off}"
    ls $@
    echo

    read -p "Are you sure? " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo
        read -p "For real? This can't be undone... " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            \rm $@
            echo "\n${Red}The nuke has been done${Color_Off}"
        fi
    fi
}

# easily exit
alias xx="exit"

# ******************************************************************************
# colors
# ******************************************************************************

# Reset
Color_Off='\033[0m'

# Regular Colors
Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
White='\033[0;37m'

function color() {
    col=$1
    IFS="\n"
    while read -r line; do
        echo "${col}${line}${Color_Off}"
    done
}

# ******************************************************************************
# editing config
# ******************************************************************************

# editing zsh config
export ZSHRC=~/.zshrc
function src() {
    source $ZSHRC
    echo "Sourced $ZSHRC" | color $Yellow
}
alias ezsh="vim $ZSHRC"

export BASHRC=~/.bashrc
function sbash() {
    source $BASHRC
    echo "Sourced $BASHRC" | color $Yellow
}
alias ebash="vim $BASHRC"

# vim config
alias v="vim"
export VIMRC=~/.vimrc
alias evim="vim $VIMRC"

# tmux config
export TMUX_CONF=~/.tmux.conf
alias emux="vim $TMUX_CONF"
alias smux="tmux source-file $TMUX_CONF"

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
    echo $files

    cmd="grep -c $query $files | uniq"
    eval $cmd | awk -F: '{printf "\033[33m" $1 ": \033[32m" $2 " MATCHES\n"}'
    num_files=$(eval $cmd | wc -l | awk '{print $1}')
    echo "${Cyan}$matches MATCHES ACROSS $num_files FILES$Color_Off"
}

# exclude wacky dirs
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
    echo $cmd
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

# ******************************************************************************
# fun functions
# ******************************************************************************

# list files with trailing whitespace
function fws() {
    echo "Files with trailing whitespace:" | color $Red
    gen_grep_exclude_flags
    eval "grep -rlI $GREP_EXCLUDE_FLAGS '[[:blank:]]$' ." | color $Yellow
}

function mksh() {
    script_name=$1
    echo "#!/bin/bash" > "$script_name.sh"
    file="$script_name.sh"
    chmod 777 "$file"
    echo "Created script file: $file" | color $Red
}

# ******************************************************************************
# useful dirs
# ******************************************************************************

alias pg_dir="cd ~/Desktop/Distributed/mapreduce"

# ******************************************************************************
# zoo stuff
# ******************************************************************************

NETID="jzc6"
ZOO_HANDLE="$NETID@node.zoo.cs.yale.edu"

function gen_ssh_key() {
    ssh-keygen -t rsa -b 4096
    ssh-copy-id $ZOO_HANDLE
}

# ssh in fast
alias zoo="ssh $ZOO_HANDLE"

# put and get files / dirs on zoo easily
function zoo_put() {
    src_path=$1
    dest_dir=$2
    flags=$3
    scp $flags $src_path "$ZOO_HANDLE:~/$dest_dir/"
}

function zoo_get() {
    src_path=$1
    dest_dir=$2
    flag=$3
    scp $flag "$ZOO_HANDLE:~/$src_path" $dest_dir
}
