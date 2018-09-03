#!/bin/bash

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
SES=$(cat $DIR/session.tmux)

shopt -s expand_aliases
alias tmux='tmux -S $DIR/tmux.socket'

if [ ! -z ${TMUX+x} ]; then
        unset TMUX
fi

if tmux has-session -t "$SES" 2>/dev/null; then
        echo "Press Ctrl+B, D to disconnect."
        read -t 10 -p "Press ENTER to continue..."
        tmux attach -t "$SES"
else
	echo "Error: server not running."
	echo "Run start.sh to start the server."
    exit 1
fi
