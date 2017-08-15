# remid
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
apt-get install -y cmake 
zynth_svn https://github.com/ssj71/reMID.lv2.git reMID
if [ ${?} -ne 0  -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd reMID/trunk
        quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}/lv2`
	sed -i -- "s/DESTINATION lib\/lv2\/remid.lv2/DESTINATION ${quoted_ZYNTHIAN_PLUGINS_DIR}\/remid/" CMakeLists.txt
	sed -i -- "s/DESTINATION lib\/lv2\/remid.lv2/DESTINATION ${quoted_ZYNTHIAN_PLUGINS_DIR}\/remid/" src/CMakeLists.txt
	sed -i -- "s/DESTINATION bin/DESTINATION ${quoted_ZYNTHIAN_PLUGINS_DIR}\/remid/" src/CMakeLists.txt
	cmake -DCMAKE_INSTALL_PREFIX="${ZYNTHIAN_PLUGINS_DIR}/lv2" .
	make
	sudo make install
	zynth_build_request ready
	make clean
	cd ../..
fi
