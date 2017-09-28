# calf
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
sudo apt-get install -y libcairo2-dev --no-install-recommends
zynth_git https://github.com/calf-studio-gear/calf.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd calf
	sh autogen.sh
	./configure --with-lv2-dir=$ZYNTHIAN_PLUGINS_DIR/lv2 --exec-prefix=/usr/local --prefix=/usr/local
	if [ RASPI = "true" ]
	then
		sed -i -- 's/, 1e-20f/, (double)1e-20f/' src/analyzer.cpp
		sed -i -- 's/, 1.0f/, (double)1.0f/' src/modules_limit.cpp
	fi
	make
	sudo make install
	zynth_build_request ready
	make clean
	cd ..
fi
