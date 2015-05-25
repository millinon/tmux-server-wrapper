#!/bin/bash

cd "$( dirname "$0" )"
source .wrapper.conf

if tmux has-session -t "${srv_name}" 2>/dev/null; then
	
	if [ ! -z "${srv_stop_cmd}" ]; then
		echo "Asking server '${srv_name}' to stop..."
		tmux send-keys -t "${srv_name}" ${srv_stop_cmd}
		
		sleep "${srv_stop_time}"
	fi

	if tmux has-session -t "${srv_name}" 2>/dev/null; then
		echo "Killing server '${srv_name}'."
		tmux kill-session -t "${srv_name}"
	fi
else
	echo "Error: server '${srv_name}' not running."
fi
