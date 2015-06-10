#!/bin/bash

source somedir/.wrapper.conf

if $TMUX has-session -t "${srv_name}" 2>/dev/null; then
	if [ ! -z ${do_unset+x} ]; then unset $TMUX; fi
	echo "Connecting to '${srv_name}'."
	echo "Press 'Ctrl+B D' to exit."
	read -t 10 -p "Press Enter to continue..."

	$TMUX a -t "${srv_name}"
else
	echo "Error: server '${srv_name}' not running."
fi
