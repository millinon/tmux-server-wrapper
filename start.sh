#!/bin/bash

source somedir/.wrapper.conf

if $TMUX has-session -t "${srv_name}" 2>/dev/null; then
	echo "Server '${srv_name}' already running"
else
        echo "Starting server..."
	if [ ! -z ${do_unset+x} ]; then unset $TMUX; fi
        $TMUX new -d -s "${srv_name}" "${srv_exe}"
fi
