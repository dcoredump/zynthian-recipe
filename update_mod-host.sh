# Mod-Host
P=`pwd`
cd "${HOME}/zynthian/zynthian-sw/mod-host"
R=`git pull`
if [ "${R}" != "Already up-to-date." ]
then
	make
	sudo make install
fi
cd "${P}"
