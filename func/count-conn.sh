#!/bin/sh
#count connections of specified port

PORT=$1
if [ -z $PORT ]; then
	read -p "which port?" PORT
fi

#lsof -i:$PORT | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort  | uniq -c | sort -n -k 1 -r
netstat -nat | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}:${PORT}\b.*([0-9]{1,3}\.){3}[0-9]{1,3}" | awk '{print $2}' | sort | uniq -c | sort -n -r -k 1

