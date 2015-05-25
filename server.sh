#!/bin/bash

IN="go"

while [ "$IN" != "stop" ]; do
	echo "Server starting."
	if ! read -p "Enter 'stop' to kill the server: " -t 5 IN; then echo; fi
	echo "Server died."
	sleep 1
done
