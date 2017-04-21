# sooperlooper
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/moddevices/sooperlooper-lv2-plugin.git sooperlooper
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd sooperlooper/sooperlooper
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
	sed -i -- 's/INSTALLATION_PATH = \$(DESTDIR)\$(INSTALL_PATH)\/\$(PLUGIN).lv2\//INSTALLATION_PATH = \/zynthian\/zynthian-plugins\/lv2\/sooperlooper.lv2/' Makefile
	make
	sudo make install
	zynth_build_request ready 
	cd ../..
fi
