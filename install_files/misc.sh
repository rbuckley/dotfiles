#!/bin/bash

# use echo <something> to output to the logfile
# use echo <something> >&3 to output to the console
log2file() {
    exec 3>&1 4>&2
    # on exit, hangup, interrupt or quit make sure we put the redirects back
    # to stdout and stderr
    trap 'exec 2>&4 1>&3' 0 1 2 3
    exec 1>${LOG_FILE} 2>&1
}
