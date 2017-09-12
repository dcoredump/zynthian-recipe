# xfade
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/x42/xfade.lv2.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
        zynth_build_request clear
	cd xfade.lv2
	sed -i -- "s,PREFIX ?= /usr/local,PREFIX ?= $ZYNTHIAN_PLUGINS_DIR,g" Makefile
	sed -i -- "s,LV2DIR ?= \$(PREFIX)/\$(LIBDIR)/lv2,LV2DIR ?= \$(PREFIX)/lv2,g" Makefile 
	sed -i -- "s,-msse -msse2 -mfpmath=sse,${CPU} ${FPU},g" Makefile
	make
	sudo make install
	make clean
	zynth_build_request ready
	cd ..
fi
