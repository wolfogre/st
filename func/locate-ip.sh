#!/bin/sh
#locate ip region

set -e

if ! command -v jq >/dev/null 2>&1; then 
	echo jq: command not found
	exit 1 
fi

IP=$1

if [[ -z $IP ]]; then
	read -p "what ip(empty for yourself)?" IP
fi

if [[ -z $IP ]]; then
	TEMP=`mktemp`
	STATUS_CODE=`curl -sS -o $TEMP -w "%{http_code}" ifconfig.me`
	if [[ $STATUS_CODE != "200" ]]; then
	        echo error $STATUS_CODE
        	cat $TEMP
	        rm -f $TEMP
        	exit 1
	fi

	IP=`cat $TEMP`
	rm -f $TEMP
fi

TEMP=`mktemp`
STATUS_CODE=`curl -sS -o $TEMP -w "%{http_code}" http://ip.taobao.com/service/getIpInfo.php?ip=$IP`

if [[ $STATUS_CODE != "200" ]]; then
	echo error $STATUS_CODE
	cat $TEMP
	rm -f $TEMP
	exit 1
fi

RESPONSE=`cat $TEMP`
rm -f $TEMP

if [[ `echo $RESPONSE | jq '.code'` != '0' ]]; then
	echo $IP `echo $RESPONSE | jq -r '.data'`
	exit 1
fi

echo $IP `echo $RESPONSE | jq -r '.data.country'` `echo $RESPONSE | jq -r '.data.area'` `echo $RESPONSE | jq -r '.data.region'` `echo $RESPONSE | jq -r '.data.county'` `echo $RESPONSE | jq -r '.data.isp'`

