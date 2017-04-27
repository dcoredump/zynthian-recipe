# mod-distortion
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/moddevices/mod-distortion.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd mod-distortion
	make
	sudo make INSTALL_PATH=$ZYNTHIAN_PLUGINS_DIR/lv2 install
	zynth_build_request ready
	make clean
	cd ..
fi
