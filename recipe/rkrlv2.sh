# rkrlv2
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/ssj71/rkrlv2.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd rkrlv2
	mkdir build
	cd build
	cmake ..
	make
	make install
	mv /usr/local/lib/lv2/rkr.lv2 ${ZYNTHIAN_PLUGINS_DIR}/lv2
	zynth_build_request ready
	make clean
	cd ../..
fi
