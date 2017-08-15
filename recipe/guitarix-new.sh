# guitarix-new
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/brummer10/GxPlugins.lv2.git guitarix-new
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
        zynth_build_request ready
        cd guitarix-new
        git submodule init
        git submodule update
        for i in `find . -name "Makefile"`
        do
                sed -i -- "s,-march=armv7-a -mfpu=vfpv3,${CPU} ${FPU},g" $i
        done
        make mod
        make install mod INSTALL_DIR=${ZYNTHIAN_PLUGINS_DIR}/lv2
        zynth_build_request ready
	make clean
        cd ..
fi
