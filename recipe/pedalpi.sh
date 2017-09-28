# pedalpi.sh
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	pip3 install PedalPi-PluginsManager
fi
