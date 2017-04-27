# mod-mda
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/moddevices/mda-lv2.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd mda-lv2
	./waf configure --lv2-user --lv2dir=$ZYNTHIAN_PLUGINS_DIR/lv2
	./waf build
	sudo ./waf -j1 install
	mkdir -p /zynthian/zynthian-plugins/lv2/mod-mda-Combo.lv2/modgui/heads/model-001
	cp /zynthian/zynthian-sw/mod-sdk/html/resources/heads/model-001/model-0800.png /zynthian/zynthian-plugins/lv2/mod-mda-Combo.lv2/modgui/heads/model-001
	zynth_build_request ready
	./waf clean
	cd ..
fi
