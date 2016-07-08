# Jack2
P=`pwd`
cd "${HOME}/zynthian/zynthian-sw/jack2"
R=`git pull`
if [ "${R}" != "Already up-to-date." ]
then
	./waf configure
	./waf build
	sudo ./waf install 
fi
cd "${P}"
