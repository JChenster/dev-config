#!/bin/bash

echo "Creating symbolic links from home directory to files here"
for f in .bashrc .bash_profile .portable_aliases.bash .tmux.conf .vimrc
do
    ln -snf $(pwd)/$f ~/$f
    echo "mapped ~/$f -> $(pwd)/$f"
done

echo "Sourcing bash files"
source ~/.bashrc
