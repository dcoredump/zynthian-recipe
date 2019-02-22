# mod-classic-midi-sequencer.lv2
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
#sudo apt-get install -y --no-install-recommends lvtk-tools
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/moddevices/mod-classic-midi-sequencer.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd mod-classic-midi-sequencer
	git checkout dev_Bram
	cd source
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}/lv2`
	sed -i -- "s/^INSTALL_PATH = \/usr\/local\/lib\/lv2/INSTALL_PATH = $quoted_ZYNTHIAN_PLUGINS_DIR/" Makefile
	sed -i -- "s/\$(DESTDIR)\$(PREFIX)\/lib\/lv2/$quoted_ZYNTHIAN_PLUGINS_DIR/" Makefile
	make
	sudo make install
	zynth_build_request ready 
	make clean
	cd ../..
fi
