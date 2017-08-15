# bolliedelay
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/MrBollie/bolliedelay.lv2.git bolliedelay
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd bolliedelay
	sed -i -- "s/lib\/lv2//" Makefile
	sudo make PREFIX="" DESTDIR="$ZYNTHIAN_PLUGINS_DIR/lv2" install
	make clean
	cd ..
fi
