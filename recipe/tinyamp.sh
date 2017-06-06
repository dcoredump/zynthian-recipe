# tinyamp
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/x42/tinyamp.lv2.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
        zynth_build_request clear
	cd tinyamp.lv2
	make
	sudo make install MOD=1 LV2DIR=$ZYNTHIAN_PLUGINS_DIR/lv2
	make clean
	zynth_build_request ready
	cd ..
fi
