# swh
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
sudo apt-get install -y --no-install-recommends xsltproc
zynth_git https://github.com/moddevices/swh-lv2.git
if [ ${?} -ne 0  -o  "${build}" = "build" ]
then
        zynth_build_request clear
	cd swh-lv2
	#sed -i -- 's/INSTALL_DIR_REALLY=~\/.lv2\/bundles/INSTALL_DIR_REALLY=\/home\/pi\/zynthian\/zynthian-plugins\/lv2/' Makefile
	sed -i -- 's/INSTALL_DIR_REALLY=~\/.lv2\/bundles/INSTALL_DIR_REALLY=\/zynthian\/zynthian-plugins\/lv2/' Makefile
	make
	sudo make install-user
	make clean
	cd ..
fi
