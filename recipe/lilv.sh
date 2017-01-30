# lilv
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get -y install swig python3-numpy-dev
cd $ZYNTHIAN_SW_DIR
zynth_git_recursive http://git.drobilla.net/lilv.git lilv
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	cd lilv
	zynth_build_request clear
	./waf configure --bindings --python=/usr/bin/python3
	./waf build
	sudo ./waf install
	zynth_build_request ready
fi
#	./waf clean
cd ..
