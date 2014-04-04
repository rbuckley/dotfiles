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



exit 0
