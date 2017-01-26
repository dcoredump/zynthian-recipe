# mod-caps
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/moddevices/caps-lv2.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	cd caps-lv2
	make
	sudo cp -R plugins/* $ZYNTHIAN_PLUGINS_DIR
	zynth_build_request ${0} ready
fi
#make clean
cd ..
