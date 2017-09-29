# pedalpi.sh
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_build_request clear
pip3 install PedalPi-PluginsManager
zynth_build_request ready
