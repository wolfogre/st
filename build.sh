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

ARGS1=$1

if [[ -z "$ARGS1" ]]; then
	ARGS1="help"
fi

case $ARGS1 in

version)
echo 'st version $VERSION, build time $BUILD_TIME'
;;

help)
echo -e "
''' >> index.sh

HELP_TMP=`mktemp`
echo -e "\tversion\tshow st version" >> $HELP_TMP
echo -e "\thelp\tshow help infomations" >> $HELP_TMP
for v in `ls func`; do
	if [[ $v = "dev.sh" ]]; then
		continue
	fi
	echo -e "\t${v%.*}\t"`head -n 2 func/$v | tail -n 1 | sed "s/#//"` >> $HELP_TMP
done

cat $HELP_TMP | column -t -s $'\t' | sort -o $HELP_TMP
INTERNAL_FUNC="(show|version|help|clean)"
cat $HELP_TMP | egrep "^  $INTERNAL_FUNC" >> index.sh
echo "" >> index.sh
cat $HELP_TMP | egrep "^  $INTERNAL_FUNC" -v >> index.sh

#rm -f $HELP_TMP

echo -e '''
"
;;

*)
AIM=/tmp/st_cache_$USER/$1.sh
if [ ! -f $AIM ]; then
	printf "loading $1 ... "
	if [[ `curl -s -o $AIM -w "%{http_code}" st.wolfogre.com/func/$1.sh?v='$VERSION'` != "200" ]]; then
        	rm -rf $AIM
		echo "cant not find $1 to run"
        	return
	fi
	echo "loaded"
fi
sh $AIM `echo $* | cut -s -d " " -f1 --complement`
;;
esac
}
''' >> index.sh

