
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
echo st version 0.6.1, build time Tue Feb 20 20:54:34 CST 2018
;;

help)
echo -e "

  clean           clean local functions cache
  help            show help infomations
  show            show function detail
  version         show st version

  adjust-time     adjust date time
  count-conn      count connections of specified port
  install-docker  install docker-ce and set mirror acceleration address
  install-go      install various version of golang
  install-svn     install svn 1.7, 1.8 or 1.9
  install-zmq     install zeromq 4.1.2
  locate-ip       locate ip region

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

