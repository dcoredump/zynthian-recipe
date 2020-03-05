# setbfreak
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/dcoredump/setBfreak
if [ ${?} -ne 0 -o  "x${build}" != "x" ]
then
	zynth_build_request clear
	cd setBfreak
        if [ "x${build}" = "xclean" ]
        then
                make clean
        fi
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}/lv2`
	sed -i -- "s/-msse -msse2 -mfpmath=sse/${CPU} ${FPU}/g" common.mak
	sed -i -- "s/^lv2dir = \$(PREFIX)\/lib\/lv2/lv2dir = ${quoted_ZYNTHIAN_PLUGINS_DIR}/" common.mak
	mv setBfreak_whirl/gui/b_whirl.c setBfreak_whirl/gui/setBfreak_whirl.c
	sed -i -- "s/b_whirl/setBfreak_whirl/g" setBfreak_whirl/Makefile
	make ENABLE_LV2=1 ENABLE_JACK=0
	sudo make install MOD=1
	zynth_build_request ready
	make clean
	cd ..
fi
