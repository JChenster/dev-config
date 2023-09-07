#!/bin/bash

echo "Creating symbolic links from home directory to files here"
for f in .bashrc .bash_profile .portable_aliases .tmux.conf .vimrc
do
    ln -snf $f "~/$f"
done

echo "Sourcing bash files"
source ~/.bashrc
