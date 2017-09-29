# lilv
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get -y install --no-install-recommends swig python3-numpy-dev
cd $ZYNTHIAN_SW_DIR
zynth_git_recursive http://git.drobilla.net/lilv.git lilv 
if [ ${?} -ne 0 -o "${build}" = "build" ]
then
	zynth_build_request clear
	cd lilv
	./waf configure --bindings --python=/usr/bin/python3
	./waf build
	sudo ./waf install
	zynth_build_request ready
	./waf clean
	cd ..
fi
