
st() {
case $1 in

version)
echo st version 0.0.0.31, build time Thu Dec 7 10:59:11 CST 2017
;;

dev)
set -e
case $2 in

clone)
read -p "use ssh or https?" PROT

case $PROT in

https)
git clone https://github.com/wolfogre/st.git
;;
ssh)
git clone git@github.com:wolfogre/st.git
;;
*)
echo unknown protocol
return
;;
esac

cd st
ls
return
;;

esac


if [[ `git config --get remote.origin.url` != "git@github.com:wolfogre/st.git" && `git config --get remote.origin.url` != "https://github.com/wolfogre/st.git" ]]; then
	echo please go to st repo dir
	return
fi

case $2 in

commit)
git add --all
git status
read -p "any message?" MSG
git commit -m "(`cat version`) $MSG"
git push origin master
;;

version)
echo current version is `cat version`
read -p "new version (empty to skip):" NEWV
if [[ -z "$NEWV" ]]; then
	echo skipped
else
	echo $NEWV".0" > version
	echo current version is `cat version`
fi
;;

*)
echo "
dev clone
"
;;

esac
set +e
;;
hello)
set -e
#show hello
echo hello st!
set +e
;;

esac
}
