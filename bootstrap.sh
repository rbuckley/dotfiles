#!/bin/bash

# 
CURDIR=`dirname $(readlink -f $0)`
INSTALL_FILES="${CURDIR}/install_files/*.sh"
LOG_FILE="${CURDIR}/install.log"

# load the install files so we can use them
for file in ${INSTALL_FILES}; do
    . ${file}
done

log2file
identify_os

# trap ctrl - c
trap ctrl_c INT HUP TERM
ctrl_c() {
    tput bold >&3
    tput setaf 1 >&3
    echo -e '\nCancelled by user' >&3
    echo -e '\nCancelled by user' >&3
    tput sgr0 >&3
    if [ -n "$!" ]; then
        kill $!
    fi
    exit 1
}


echo '================================================================================================' >&3
echo 'Setting up a new workstation:' >&3
echo '================================================================================================' >&3

echo '------------------------------------------------------------------------------------------------' >&3
echo 'Installing package dependencies:' >&3
echo '------------------------------------------------------------------------------------------------' >&3
## apt install everything we need to build from source
sudo apt install build-essential curl

echo '------------------------------------------------------------------------------------------------' >&3
echo 'Initializing submodules:' >&3
echo '------------------------------------------------------------------------------------------------' >&3
git submodule init
git submodule update

echo '------------------------------------------------------------------------------------------------' >&3
echo 'Installing neovim:' >&3
echo '------------------------------------------------------------------------------------------------' >&3
pushd neovim
git checkout stable
sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
make CMAKE_BUILD_TYPE=Release
sudo make install
popd

echo '------------------------------------------------------------------------------------------------' >&3
echo 'Installing tmux:' >&3
echo '------------------------------------------------------------------------------------------------' >&3
pushd tmux/tmux
git checkout 3.1
sudo apt install -t libevent-dev libncurses5-dev
sh autogen.sh
./configure && make
sudo make install
popd

mkdir ${CURDIR}/nodejs
pushd nodejs
NODE_VER=v12.16.2
DISTRO=linux-x64
sudo mkdir -p /usr/local/lib/nodejs
curl -O -L https://nodejs.org/dist/${NODE_VER}/node-${NODE_VER}-${DISTRO}.tar.xz 
sudo tar Jvxf nodejs/node-${NODE_VER}-${DISTRO}.tar.xz -C /usr/local/lib/nodejs


mkdir ${CURDIR}/openvpn
pushd openvpn
sudo apt install -y vpnc-scripts libssl-dev libxml2-dev
curl -O -L ftp://ftp.infradead.org/pub/openconnect/openconnect-8.08.tar.gz
tar vxzf openconnect-8.08.tar.gz
pushd openconnect-8.08
./configure
make 
sudo make install

exit 0
