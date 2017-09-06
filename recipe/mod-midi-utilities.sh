# mod-midi-utilities
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/moddevices/mod-midi-utilities.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd mod-midi-utilities
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}/lv2`
	sed -i -- "s/\$(DESTDIR)\/usr\/lib\/lv2/${quoted_ZYNTHIAN_PLUGINS_DIR}/" Makefile
	make
	make install
	zynth_build_request ready
	make clean
	cd ..
fi
