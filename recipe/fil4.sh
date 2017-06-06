# fil4
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get install -y libpango1.0-dev libcairo2-dev
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/x42/fil4.lv2.git fil4
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd fil4
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}/lv2`
	sed -i -- "s/LV2DIR ?= \$(PREFIX)\/lib\/lv2/LV2DIR ?= $quoted_ZYNTHIAN_PLUGINS_DIR/" Makefile
	sed -i -- "s/PREFIX ?= \/usr\/local/PREFIX ?= $quoted_ZYNTHIAN_PLUGINS_DIR/" Makefile
	sed -i -- "s/-msse -msse2 -mfpmath=sse/${CPU} ${FPU}/" Makefile
	make submodules
	make MOD=1
	sudo make DESTDIR="" MOD=1 install
	rm -r ${ZYNTHIAN_PLUGINS_DIR}/lv2/share ${ZYNTHIAN_PLUGINS_DIR}/lv2/bin
	zynth_build_request ready
	make clean
	cd ..
fi
