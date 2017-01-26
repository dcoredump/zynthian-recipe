# mod-mda
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/moddevices/mda-lv2.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	cd mda-lv2
	./waf configure --lv2-user --lv2dir=$ZYNTHIAN_PLUGINS_DIR
	./waf build
	sudo ./waf -j1 install
	zynth_build_request ${0} ready
fi
#./waf clean
cd ..
