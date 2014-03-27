#!/bin/bash

BACKUPS_DIR="$HOME/.backups"

if [ ! -f $HOME/.dotfiles ]; then
    git clone https://github.com/rbuckley/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
fi

backup() {
    cp "$HOME/.$1" "$BACKUPS_DIR/$1.bak"
}

link() {
    backup $1
    rm -f "$HOME/.$1"
    ln -s "`pwd`/$2/$1" "$HOME/.$1"
}

if [ ! -d $BACKUPS_DIR ]; then
    echo "Making backup dir...."
    mkdir $BACKUPS_DIR
fi

echo "init vundle...."
git submodule init
git submodule update

link vim vim-files
link vimrc vim-files
vim +BundleInstall +qall

