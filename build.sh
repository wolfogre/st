#!/bin/bash

set -e

i=0
for v in `cat version | xargs -d '.'`; do 
	VERSION_ARR[${i}]=${v}
	let i+=1
done

let i-=1
let VERSION_ARR[${i}]+=1

VERSION=${VERSION_ARR[1]}
for ((i=1; i<${#VERSION_ARR[*]}; i++)) {
	VERSION=${VERSION}.${VERSION_ARR[${i}]}
}
echo $VERSION > version

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
	echo "${v%.*})" >> all.sh
	echo "set -e" >> all.sh
	cat func/$v >> all.sh
	echo "set +e" >> all.sh
	echo ";;" >> all.sh
done

echo -e "\nesac\n}" >> all.sh
