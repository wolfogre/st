#!/bin/bash

set -e

i=0
for v in `cat version | xargs -d '.'`; do 
	VERSION_ARR[${i}]=${v}
	let i+=1
done

let i-=1
let VERSION_ARR[${i}]+=1

VERSION=${VERSION_ARR[0]}
for ((i=1; i<${#VERSION_ARR[*]}; i++)) {
	VERSION=${VERSION}.${VERSION_ARR[${i}]}
}
echo $VERSION > version

echo build $VERSION ...

BUILD_TIME=`date`

rm -rf index.sh
echo '''
rm /tmp/st_cache_$USER -rf
mkdir /tmp/st_cache_$USER
st() {
case $1 in

version)
echo 'st version $VERSION, build time $BUILD_TIME'
;;

help)
echo -e "
''' >> index.sh

HELP_TMP=`mktemp`
echo -e "\tversion\tshow st version" >> $HELP_TMP
for v in `ls func`; do
	if [[ $v = "dev.sh" ]]; then
		continue
	fi
	echo -e "\t${v%.*}\t"`head -n 2 func/$v | tail -n 1 | sed "s/#//"` >> $HELP_TMP
done

cat $HELP_TMP | column -t -s $'\t' >> index.sh
rm -f $HELP_TMP

echo -e '''
"
;;

*)
AIM=/tmp/st_cache_$USER/$1.sh
if [ ! -f $AIM ]; then
	if [[ `curl -s -o $AIM -w "%{http_code}" st.wolfogre.com/func/$1.sh` != "200" ]]; then
        	rm -rf $AIM
		echo "cant not find $1 to run"
        	return
	fi
fi
sh $AIM `echo $* | cut -s -d " " -f1 --complement`
;;
esac
}
''' >> index.sh

