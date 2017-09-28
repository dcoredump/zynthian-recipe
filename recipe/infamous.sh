# infamous
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
sudo apt-get install -y libzita-resampler-dev --no-install-recommends
zynth_git https://github.com/ssj71/infamousPlugins.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd infamousPlugins
	mkdir build
	cd build
	cmake -DLIBDIR="" -DCMAKE_INSTALL_PREFIX=${ZYNTHIAN_PLUGINS_DIR} ..
	for i in `find src -name cmake_install.cmake`
	do
		sed -i -- "s/lib\/lv2/lv2/" $i
	done
	make
	sudo make install
	mv /zynthian/zynthian-plugins/bin/infamous-rule /usr/local/bin
	make clean
	cd ..
fi
