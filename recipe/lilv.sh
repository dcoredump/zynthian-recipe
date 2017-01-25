# lilv
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get -y install swig python3-numpy-dev
cd $ZYNTHIAN_SW_DIR
zynth_git_recursive http://git.drobilla.net/lilv.git lilv
if [ ${?} -ne 0 -o  "${1}" = "build" ]
then
	cd lilv
	./waf configure --bindings --python=/usr/bin/python3
	./waf build
	sudo ./waf install
fi
#	./waf clean
cd ..
