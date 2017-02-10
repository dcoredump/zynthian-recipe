# setbfree

. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/dcoredump/setBfree.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd setBfree
        if [ "${build}" = "clean" ]
        then
                make clean
        fi
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}`
	sed -i -- "s/-msse -msse2 -mfpmath=sse/${CPU} ${FPU}/g" common.mak
	sed -i -- "s/^lv2dir = \$(PREFIX)\/lib\/lv2/lv2dir = ${quoted_ZYNTHIAN_PLUGINS_DIR}/" common.mak
	make ENABLE_LV2=1 ENABLE_JACK=0
	sudo make install MOD=1
	zynth_build_request ready
fi
cd ..

exit 0
