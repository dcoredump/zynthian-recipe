# LV2, lilv and Python bindings
P=`pwd`
cd "${HOME}/zynthian/zynthian-sw/lv2"
R=`git pull` 
if [ "${R}" != "Already up-to-date." ]
then
	./waf configure
	./waf build
	sudo ./waf install
fi
cd ../serd
R=`git pull` 
if [ "${R}" != "Already up-to-date." ]
then
	./waf configure
	./waf build
	sudo ./waf install
fi
cd ../sord
R=`git pull` 
if [ "${R}" != "Already up-to-date." ]
then
	./waf configure
	./waf build
	sudo ./waf install
fi
cd ../sratom
R=`git pull` 
if [ "${R}" != "Already up-to-date." ]
then
	./waf configure
	./waf build
	sudo ./waf install
fi
cd ../lilv
R=`git pull` 
if [ "${R}" != "Already up-to-date." ]
then
#./waf configure --bindings --python=/usr/bin/python2
#./waf build
#sudo ./waf install
#./waf clean
	./waf configure --bindings --python=/usr/bin/python3
	./waf build
	sudo ./waf install
fi
cd ../lilv_python_examples
R=`git pull` 
if [ "${R}" != "Already up-to-date." ]
then
	2to3 -w *.py
	export PYTHONPATH="/usr/local/lib/python3/dist-packages"
	python3 lv2ls.py
fi
cd "${P}"
