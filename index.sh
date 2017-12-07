
rm /tmp/st_cache_$USER -rf
mkdir /tmp/st_cache_$USER
st() {
case $1 in

version)
echo st version 0.2.6, build time Thu Dec 7 17:00:19 CST 2017
;;

help)
echo -e "

  version     show st version
  dev         developing tools for st
  hello       show hello
  install-go  install various version of golang

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
sh $AIM `echo $* | cut -d " " -f1 --complement`
;;
esac
}

