# lvtk
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/lvtk/lvtk.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd lvtk
	CFLAGS="${CFLAGS} NDEBUG=1" ./waf configure --disable-ui --disable-examples
	./waf build
	sudo ./waf install
	zynth_build_request ready
	./waf clean
	cd ..
fi
