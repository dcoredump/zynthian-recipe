# pedalpi.sh
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_build_request clear
pip3 install setuptools wheel PedalPi-PluginsManager
pip3 install pedalpi-pluginsmanager==0.6.0
zynth_build_request ready
