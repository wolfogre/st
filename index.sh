
if [[ -n "$ST_TEMP" ]]; then
	rm $ST_TEMP -rf
fi


export ST_TEMP=$(mktemp -d "/tmp/st.tmp.XXXXX")
trap "rm $ST_TEMP -rf" EXIT

st() {

ARGS1=$1

if [[ -z "$ARGS1" ]]; then
	ARGS1="help"
fi

case $ARGS1 in

version)
echo st version 0.5.7, build time Fri Feb 9 15:17:39 CST 2018
;;

help)
echo -e "

  help                 show help infomations
  version              show st version

  func/adjust-time     adjust date time
  func/clean           clean local functions cache
  func/count-conn      count connections of specified port
  func/dev             developing tools for st
  func/install-docker  install docker-ce and set mirror acceleration address
  func/install-go      install various version of golang
  func/install-svn     install svn 1.7, 1.8 or 1.9
  func/install-zmq     install zeromq 4.1.2
  func/locate-ip       locate ip region
  func/show            show function detail

"
;;

*)
AIM=$ST_TEMP/$1.sh
if [ ! -f $AIM ]; then
	printf "loading $1 ... "
	if [[ `curl -s -o $AIM -w "%{http_code}" st.wolfogre.com/func/$1.sh` != "200" ]]; then
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

