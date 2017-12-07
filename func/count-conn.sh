#!/bin/sh
#count connections of specified port

set -e

echo $*

PORT=$1
if [ -z $PORT ]; then
	read -p "which port?" PORT
fi

echo port $PORT

lsof -i:$PORT | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort  | uniq -c | sort -n -k 1 -r

