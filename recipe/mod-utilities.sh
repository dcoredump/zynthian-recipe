# mod-utilities
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/moddevices/mod-utilities.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	cd mod-utilities
	zynth_build_request clear
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}`
	sed -i -- "s/^INSTALL_PATH = \/usr\/local\/lib\/lv2/INSTALL_PATH = ${quoted_ZYNTHIAN_PLUGINS_DIR}/" Makefile
	make
	sudo make install
	zynth_build_request ready
fi
#make clean
cd ..
