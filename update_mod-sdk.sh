# mod-sdk
P=`pwd`
cd "${HOME}/zynthian/zynthian-sw/mod-sdk"
R=`git pull`
if [ "${R}" != "Already up-to-date." ]
then
	python3 setup.py build
fi
cd "${P}"
