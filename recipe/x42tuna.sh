# x42tuna
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/x42/tuna.lv2.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
        zynth_build_request clear
	cd tuna.lv2
	sed -i -- "s,PREFIX ?= /usr/local,PREFIX ?= $ZYNTHIAN_PLUGINS_DIR,g" Makefile
	sed -i -- "s,LV2DIR ?= \$(PREFIX)/lib/lv2,LV2DIR ?= \$(PREFIX)/lv2,g" Makefile 
	sed -i -- "s,-msse -msse2 -mfpmath=sse,${CPU} ${FPU},g" Makefile
	git submodule init
	git submodule update
	make MOD=1
	sudo make install MOD=1
	make clean
	zynth_build_request ready
	cd ..
fi
