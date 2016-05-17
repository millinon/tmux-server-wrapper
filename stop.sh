#!/bin/bash

DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
SES=$(cat $DIR/session.tmux)

shopt -s expand_aliases
alias tmux='tmux -S $DIR/tmux.socket'

if [ ! -z ${TMUX+x} ]; then
        unset TMUX
fi

if tmux has-session -t "$SES" 2>/dev/null; then
	echo "Killing session ${SES}."
#	tmux send-keys -t "$SES" "stop Enter"
#	sleep 5
	tmux kill-session -t "$SES"
else
	echo "Error: session $SES not running."
fi
