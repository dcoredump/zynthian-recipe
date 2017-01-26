# mod-distortion
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/moddevices/mod-distortion.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	cd mod-distortion
	make
	sudo make INSTALL_PATH=$ZYNTHIAN_PLUGINS_DIR install
	zynth_build_request ${0} ready
fi
#make clean
cd ..
