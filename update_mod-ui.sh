# mod-ui
P=`pwd`
cd "${HOME}/zynthian/zynthian-sw/mod-ui"
R=`git pull`
if [ "${R}" != "Already up-to-date." ]
then
	cd utils
	make
	cd ..
	sed -i -- '/remove -1/,+0 s/^/# /' mod/host.py
fi
cd "${P}"
