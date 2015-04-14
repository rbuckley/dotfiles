#!/bin/bash
tmux showenv -g TMUX_SERIAL_$(tmux display -p "#D" | tr -d %) | sed 's/^.*=//'
