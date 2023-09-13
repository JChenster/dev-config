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

# shortcuts
alias cl="clear"
alias xx="exit"

# comments on how to navigate bash command line in Mac
# opt-left, opt-right to go backwards/forwards a word

# only exit with crtl+d upon 10th click
set -o ignoreeof

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

export BASH_PROFILE=~/.bash_profile
function sprof() {
    source $BASH_PROFILE
    echo "Sourced $BASH_PROFILE" | color $Yellow
}
alias eprof="vim $BASH_PROFILE"

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

alias econf="vim $BASHRC $TMUX_CONF $VIMRC $BASH_PROFILE"

# ******************************************************************************
# tmux
# ******************************************************************************
# killing panes and windows
alias tkp="tmux kill-pane -t $1"
alias tkw="tmux kill-window -t $1"

# send a command to all panes in current session, window
function all_panes() {
    session=`tmux display-message -p '#S'`
    window=`tmux display-message -p -F '#{window_index}'`
    for pane in `tmux list-panes -t $session:$window -F '#P' | sort`; do
        tmux send-keys -t "$session:$window.$pane" "$@" C-m
    done
}

function all_src() {
    for cmd in sbash sprof
    do
        all_panes $cmd
        # undo any bad vim actions
        all_panes Escape
        all_panes u
    done
}

function tatt() {
    if [ "$#" -eq 0 ]
    then
        tmux attach -t 0
    else
        tmux attach -t $1
    fi
}

# ******************************************************************************
# source portable aliases
# - grep magic
# ******************************************************************************

. ~/.portable_aliases

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

function ff() {
    pattern=$1
    find . -print | grep -i $pattern
}

function cmp_cpp() {
    file_prefix=$1
    g++ -std=c++20 -o $1 "$1.cpp"
}
export -f cmp_cpp

# ******************************************************************************
# useful dirs
# ******************************************************************************

DB_DIR="~/Desktop/Databases/CPSC-440-FA23"
alias db_dir="cd $DB_DIR"
alias db_sdir="cd $DB_DIR/src/java/simpledb"
alias db_tdir="cd $DB_DIR/test/simpledb"

alias pg_dir="cd ~/Desktop/Spring2023/Distributed/mapreduce"

SP_DIR="~Desktop/SeniorProject"
alias sp_dir="cd $SP_DIR"

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

# ******************************************************************************
# git stuff
# ******************************************************************************
alias ga="git add $1"
alias gaa="git add --all"
alias gd="git diff"
alias gco="git commit -m"
alias gs="git status"

# ******************************************************************************
# current workflow
# ******************************************************************************

# cpsc 540
# run a unit test
function dbut() {
    test=$1
    db_dir
    ant runtest "-Dtest=${test}Test"
    cd -
}

function qemu_start() {
    out_dir="/Users/jeff/Desktop/SeniorProject/FreeRTOS/FreeRTOS/Demo/CORTEX_MPS2_QEMU_IAR_GCC/build/gcc/output"
    qemu-system-arm -machine mps2-an385 -cpu cortex-m3 -kernel "$out_dir/RTOSDemo.out" -monitor none -nographic -serial stdio
}
