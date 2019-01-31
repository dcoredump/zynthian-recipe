# raffo.lv2
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
sudo apt-get install -y --no-install-recommends libgtkmm-2.4-dev
zynth_git https://github.com/nicoroulet/moog.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd moog
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
	sed -i -- 's/^INSTALL_DIR.\+$/INSTALL_DIR = ${ZYNTHIAN_PLUGINS_DIR}\/lv2/' Makefile
	sed -i -- 's/-m64//' Makefile
	make
	sudo make install
	zynth_build_request ready 
	make clean
	cd ..
fi
