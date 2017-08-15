# midifilter
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/x42/midifilter.lv2.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd midifilter.lv2
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}/lv2`
	sed -i -- "s/-msse -msse2 -mfpmath=sse /${CPU} ${FPU}/" Makefile
	sed -i -- "s/LV2DIR ?= \$(PREFIX)\/lib\/lv2/LV2DIR ?= ${quoted_ZYNTHIAN_PLUGINS_DIR}/" Makefile
	sed -i -- "s/a lv2:Plugin/a lv2:Plugin, mod:MIDIPlugin/" ttf.h
	sed '2i @prefix mod: <http://moddevices.com/ns/mod#> .' manifest.ttl.in >manifest.ttl.in.new
	mv manifest.ttl.in.new manifest.ttl.in
	make MOD=1
	sudo make install MOD=1
	zynth_build_request ready
	make clean
	cd ..
fi
