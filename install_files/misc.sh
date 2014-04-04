#!/bin/bash

log2file() {
    echo "Creating logfile redirects to ${LOG_FILE}..."
    # 
    exec 3>&1 4>&2
    # on exit, hangup, interrupt or quit make sure we put the redirects back
    # to stdout and stderr
    trap 'exec 2>&4 1>&3' 0 1 2 3
    exec 1>${LOG_FILE} 2>&1
}

identify_os() {
    echo "Your good"
}
