# midigen
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/x42/midigen.lv2.git midigen
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd midigen
	make OPTIMIZATIONS="${CPU} ${FPU}"
	make DESTDIR="$ZYNTHIAN_PLUGINS_DIR" PREFIX="" LIBDIR="" install 
	zynth_build_request ready
	make clean
	cd ..
fi
