#!/bin/bash

link() {
    rm -f "$HOME/.$1"
    ln -s "`pwd`/$2/$1" "$HOME/.$1"
}

echo "init vundle...."
git submodule init
git submodule update

link vim vim-files
link vimrc vim-files
vim +PluginInstall +qall

