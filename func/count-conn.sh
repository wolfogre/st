#!/bin/sh
#count connections of specified port

set -e

PORT=$!
if [ -z $PORT ]; then
	read -p "which port?" PORT
fi

lsof -i:$PORT | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort  | uniq -c | sort -n -k 1 -r

