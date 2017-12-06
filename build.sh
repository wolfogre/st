#!/bin/bash

set -e

i=0
for v in `cat version`; do 
	VERSION_ARR[${i}]=${v}
	let i+=1
done

let i-=1
let VERSION_ARR[${i}]+=1

rm -rf version
for v in ${VERSION_ARR[*]}; do
        echo $v >> version
done

VERSION=${VERSION_ARR[1]}
for ((i=1; i<${#VERSION_ARR[*]}; i++)) {
	VERSION=${VERSION}.${VERSION_ARR[${i}]}
}

echo build $VERSION ...

BUILD_TIME=`date`

rm -rf all.sh
echo '''
st() {
case $1 in
version)
echo 'st version $VERSION, build time $BUILD_TIME'
;;
''' >> all.sh

for v in `ls func`; do
	cat func/$v >> all.sh
done

echo '''
	esac
}
''' >> all.sh
