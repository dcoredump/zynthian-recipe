# surge.lv2
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y --no-install-recommends libfreetype6-dev
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/surge-synthesizer/surge.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd surge
	git submodule update --init --recursive
	export PATH=${PATH}:/usr/local/premake-core/bin/release/
	./build-linux -p lv2 premake
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
	make
	sudo make install
	zynth_build_request ready 
	make clean
	cd ..
fi
