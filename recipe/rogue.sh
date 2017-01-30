# rogue
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
sudo apt-get install -y libsamplerate0-dev lvtk-tools
zynth_git https://github.com/timowest/rogue.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd rogue
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}`
	sed -i -- "s/INSTALL_DIR = \/usr\/local\/lib\/lv2/INSTALL_DIR = ${quoted_ZYNTHIAN_PLUGINS_DIR}/" Makefile
	sed -i -- 's/\$(BUNDLE): manifest.ttl rogue.ttl presets.ttl rogue.so rogue-gui.so presets styles/\$(BUNDLE): manifest.ttl rogue.ttl presets.ttl rogue.so presets styles/' Makefile
	sed -i -- 's/pkg-config --cflags --libs lvtk-plugin-1/pkg-config --cflags --libs lvtk-plugin-2/' Makefile
	sed -i -- 's/pkg-config --cflags --libs lvtk-ui-1/pkg-config --cflags --libs lvtk-ui-2/' Makefile
	export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig/"
	make
	sudo make install
	zynth_build_request ready
fi
#make clean
cd ..
