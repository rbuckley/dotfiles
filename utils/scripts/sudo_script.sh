#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "Must be run as root" 1>&2
    exit 1
fi
