#!/bin/bash

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/local/bin.
# It's assumed that wget and a C/C++ compiler are installed.

# exit on error
set -e

TMUX_VERSION_MAJOR=1.9
TMUX_VERSION_MINOR=a

# create our directories
mkdir -p $HOME/local $HOME/tmux_tmp
cd $HOME/tmux_tmp

# cleanup
function cleanup() {
    cd $HOME
    rm -rf $HOME/tmux_tmp

    if [[ $1 -eq 0 ]]; then
        echo "$HOME/local/bin/tmux is now available. You can optionally add $HOME/local/bin to your PATH."
        exit 0
    else
        echo "Errors installing"
        exit 1
    fi
}
# download the most recent tmux source
wget -O tmux-${TMUX_VERSION_MAJOR}${TMUX_VERSION_MINOR}.tar.gz http://sourceforge.net/projects/tmux/files/tmux/tmux-${TMUX_VERSION_MAJOR}/tmux-${TMUX_VERSION_MAJOR}${TMUX_VERSION_MINOR}.tar.gz/download

if [[ $EUID -ne 0 ]]; then
    echo -n "This will be installed locally, is that okay [y/n]?: "
    read choice
    if [[ $choice -eq 'n' ]]; then
        echo "Exiting install, to install globably run as root"
        cleanup 1
    fi
    # if we are not running this as root, just install locally
    # download source files for libevent, and ncurses
    wget https://github.com/downloads/libevent/libevent/libevent-2.0.19-stable.tar.gz
    wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz

    # extract files, configure, and compile

    ############
    # libevent #
    ############
    tar xvzf libevent-2.0.19-stable.tar.gz
    cd libevent-2.0.19-stable
    ./configure --prefix=$HOME/local --disable-shared
    make
    make install
    cd ..

    ############
    # ncurses  #
    ############
    tar xvzf ncurses-5.9.tar.gz
    cd ncurses-5.9
    ./configure --prefix=$HOME/local
    make
    make install
    cd ..

    ############
    # tmux     #
    ############
    tar xvzf tmux-${TMUX_VERSION_MAJOR}${TMUX_VERSION_MINOR}.tar.gz
    cd tmux-${TMUX_VERSION_MAJOR}${TMUX_VERSION_MINOR}
    ./configure CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include"
    CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib" make
    cp tmux $HOME/local/bin

    cleanup 0
else
    # since we are root just use package managers to install ncurses and libevent
    OS=$(lsb_release -si) 
    if [[ $OS -eq 'Fedora' ]]; then
        echo "installing dependencies for Fedora"
        #yum install libevent-devel
        #yum install ncurses-devel
    elif [[ $OS -eq 'Ubuntu' ]]; then
        echo "installing dependencies for Ubuntu"
        #apt-get install libevent-devel
        #apt-get install ncurses-devel
    else
        echo "Unsupported OS ${OS}"
        cleanup 1
    fi

    cd tmux-${TMUX_VERSION_MAJOR}${TMUX_VERSION_MINOR}
    ./configure
    make
    make install
    
    cleanup $?

fi

