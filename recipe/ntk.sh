# ntk
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git git://git.tuxfamily.org/gitroot/non/fltk.git ntk
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd ntk
	./waf configure
	./waf
	sudo ./waf install
	zynth_build_request ready
	clean
	./waf clean
	cd ..
fi
