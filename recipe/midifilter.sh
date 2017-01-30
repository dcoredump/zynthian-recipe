# midifilter
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/x42/midifilter.lv2.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd midifilter.lv2
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}`
	sed -i -- "s/-msse -msse2 -mfpmath=sse /${CPU} ${FPU}/" Makefile
	sed -i -- "s/LV2DIR ?= \$(PREFIX)\/lib\/lv2/LV2DIR ?= ${quoted_ZYNTHIAN_PLUGINS_DIR}/" Makefile
	make MOD=1
	sudo make install MOD=1
	zynth_build_request ready
fi
#make clean
cd ..
