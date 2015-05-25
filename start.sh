#!/bin/bash

cd "$( dirname "$0" )"
source .wrapper.conf

if tmux has-session -t "${srv_name}" 2>/dev/null; then
	echo "Server '${srv_name}' already running"
else
        echo "Starting server..."
	if [ ! -z ${do_unset+x} ]; then unset TMUX; fi
        tmux new -d -s "${srv_name}" "${srv_exe}"
fi
