# calf
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/calf-studio-gear/calf.git
sudo apt-get install -y libcairo2-dev
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd calf
	sh autogen.sh
	#sed -i -- 's/, 1e-20f/, (double)1e-20f/' src/analyzer.cpp
	#sed -i -- 's/, 1.0f/, (double)1.0f/' src/modules_limit.cpp
	make
	sudo make install
	zynth_build_request ready
fi
#make clean
cd ..
