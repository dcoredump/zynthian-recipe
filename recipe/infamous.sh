# infamous
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get install -y ntk ntk-fluid 
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/ssj71/infamousPlugins.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd infamousPlugins
	mkdir build
	cd build 
	cmake -DCMAKE_INSTALL_PREFIX="${ZYNTHIAN_PLUGINS_DIR}/lv2" -DLIBDIR="" ..
	make
        sudo make install
	rm -r ${ZYNTHIAN_PLUGINS_DIR}/lv2/lib/lv2/midigen.lv2
	mv ${ZYNTHIAN_PLUGINS_DIR}/lv2/lib/lv2/* ${ZYNTHIAN_PLUGINS_DIR}/lv2
	rm -r ${ZYNTHIAN_PLUGINS_DIR}/lv2/lib
	zynth_build_request ready
	make clean
	cd ../..
fi
