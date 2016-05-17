#!/bin/bash


DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

SES=$(cat $DIR/session.tmux)

shopt -s expand_aliases
alias tmux='tmux -S $DIR/tmux.socket'

if [ ! -z ${TMUX+x} ]; then
	unset TMUX
fi

if tmux has-session -t "$SES" 2>/dev/null; then
	echo "Session ${SES} already running."
    exit 1
else
	echo "Starting session ${SES}..."
	tmux new -s "$SES" -d "$DIR/server.sh"
fi
