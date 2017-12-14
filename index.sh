
rm /tmp/st_cache_$USER -rf
mkdir /tmp/st_cache_$USER
st() {

ARGS1=$1

if [[ -z "$ARGS1" ]]; then
	ARGS1="help"
fi

case $ARGS1 in

version)
echo st version 0.4.21, build time Thu Dec 14 14:03:51 CST 2017
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

"
;;

*)
printf "loading $1 ... "
AIM=/tmp/st_cache_$USER/$1.sh
if [ ! -f $AIM ]; then
	if [[ `curl -s -o $AIM -w "%{http_code}" st.wolfogre.com/func/$1.sh?v=0.4.21` != "200" ]]; then
        	rm -rf $AIM
		echo "cant not find $1 to run"
        	return
	fi
fi
echo "loaded"
sh $AIM `echo $* | cut -s -d " " -f1 --complement`
;;
esac
}

