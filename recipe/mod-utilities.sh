# mod-utilities
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/moddevices/mod-utilities.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd mod-utilities
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}/lv2`
	sed -i -- "s/^INSTALL_PATH = \/usr\/local\/lib\/lv2/INSTALL_PATH = ${quoted_ZYNTHIAN_PLUGINS_DIR}/" Makefile
	make MOD=1
	sudo make MOD=1 install 
	zynth_build_request ready
	make clean
	cd ..
fi
