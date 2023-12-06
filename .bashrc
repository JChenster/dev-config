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

# default cp
alias dcp="\cp"

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

alias ctags='/opt/homebrew/bin/ctags'
alias gen_ctags="ctags -R *"

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

# only for local machine
export ISLOCAL=true

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
alias eport="vim ~/.portable_aliases.bash"
alias ework="vim ~/.workflow.bash"

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

# source bash config files on all panes in current tmux window
# TODO: this solution is very hacky, is there a cleaner solution?
function all_src() {
    for cmd in sbash sprof
    do
        all_panes $cmd
        # undo any bad vim actions
        all_panes Escape
        all_panes u
    done
}

# attach tmux session of the arg specified (or the last one if unspecified)
function tatt() {
    if [ "$#" -eq 0 ]
    then
        tmux attach -t 0
    else
        tmux attach -t $1
    fi
}

# ******************************************************************************
# sourcing other files
# ******************************************************************************

# for portable aliases we want to be able to call in non-bash programs like vim
. ~/.portable_aliases.bash

# source workflow config
if test -f ~/.workflow.bash; then
    . ~/.workflow.bash
fi

# ******************************************************************************
# fun functions
# ******************************************************************************

# list files with trailing whitespace
function fws() {
    echo "Files with trailing whitespace:" | color $Red
    gen_grep_exclude_flags
    eval "grep -rlI $GREP_EXCLUDE_FLAGS '[[:blank:]]$' ." | color $Yellow
}

# quickly create a bash script
function mksh() {
    script_name=$1
    echo "#!/bin/bash" > "$script_name.sh"
    file="$script_name.sh"
    chmod 777 "$file"
    echo "Created script file: $file" | color $Red
    vim $file
}

# find a file by name in a subdirectory
function ff() {
    pattern=$1
    find . -print | grep -i $pattern
}

# compile c++
function cmp_cpp() {
    file_prefix=$1
    g++ -std=c++20 -o $1 "$1.cpp"
}
export -f cmp_cpp

# show the current path in your shell
PS1="\[\`if [[ \$? = "0" ]]; then echo '\e[32m\h\e[0m'; else echo '\e[31m\h\e[0m' ; fi\`:\w\n\$ "

function kill_grep() {
    ps aux | grep $1

    read -p "Are you sure? " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo
        read -p "For real? This can't be undone... " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            ps aux | grep $1 | awk '{print $2}' | xargs kill -9
            echo "\n${Red}Deleted processes! ${Color_Off}"
        fi
    fi

}

alias tree2="tree -v -L 2"
alias tree3="tree -v -L 3"
alias tree4="tree -v -L 4"

# ******************************************************************************
# server stuff
# ******************************************************************************

# in order to use this stuff, NETID variable must be set
ZOO_HANDLE="$NETID@cobra.zoo.cs.yale.edu"
GRACE_HANDLE="cpsc424_$NETID@grace.ycrc.yale.edu"
GRACE_TRANSFER_HANDLE="cpsc424_$NETID@transfer-grace.ycrc.yale.edu"

function gen_ssh_key() {
    ssh-keygen -t rsa -b 4096
    ssh-copy-id $ZOO_HANDLE
}

# ssh in fast
alias zoo="ssh $ZOO_HANDLE"
alias grace="ssh $GRACE_HANDLE"

function remote_put() {
    host=$1
    src_path=$2
    dest_dir=$3
    flags=$4

    scp $flags $src_path "$host:~/$dest_dir/"
}

# [src_path] [dest_dir] [flags]
function zoo_put() {
    remote_put $ZOO_HANDLE $1 $2 $3
}

function grace_put() {
    remote_put $GRACE_TRANSFER_HANDLE $1 $2 $3
}

function remote_get() {
    host=$1
    src_path=$2
    dest_dir=$3
    flag=$4

    scp $flag "$host:~/$src_path" $dest_dir
}

function zoo_get() {
    remote_get $ZOO_HANDLE $1 $2 $3
}

function grace_get() {
    remote_get $GRACE_TRANSFER_HANDLE $1 $2 $3
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
# to categorize
# ******************************************************************************
