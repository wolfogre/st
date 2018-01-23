#!/bin/sh
#show function detail

FUNC=$1

if [ -z $FUNC ]; then
	read -p "which function?" FUNC
fi

AIM=$ST_TEMP/$FUNC.sh
if [ ! -f $AIM ]; then
        if [[ `curl -s -o $AIM -w "%{http_code}" st.wolfogre.com/func/$1.sh` != "200" ]]; then
                rm -rf $AIM
                echo "cant not find $1 to show"
                exit 1
        fi
	cat $AIM
else
	cat $AIM
	echo -e "\n# IT IS FORM LOCAL CACHE"
fi

