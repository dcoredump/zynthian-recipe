# zynaddsubfx
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y liblo0-dev libmxml-dev cmake fftw3-dev zlib1g-dev
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git git://git.code.sf.net/p/zynaddsubfx/code
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	if [ -d code ]
	then
		ln -s code zynaddsubfx
	fi
	cd zynaddsubfx
	if [ ! -d build ]
	then
		mkdir build
	fi
	cd build
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}/lv2`
	OLD_DATE=`date +%Y%m%d%H%M.%S`
	cmake ..
	for i in `find . -name "*.cmake"`
	do
        	sed -i -- "s/\${CMAKE_INSTALL_PREFIX}\/lib\/lv2/${quoted_ZYNTHIAN_PLUGINS_DIR}/" $i
        	touch -c $i -t$OLD_DATE
	done
	sed -i -- 's/-lX11//' ./src/Plugin/ZynAddSubFX/CMakeFiles/ZynAddSubFX_lv2.dir/link.txt
	sed -i -- 's/-lX11//' ./src/Plugin/ZynAddSubFX/CMakeFiles/ZynAddSubFX_vst.dir/link.txt
	sed -i -- 's/-lGL//' ./src/Plugin/ZynAddSubFX/CMakeFiles/ZynAddSubFX_lv2.dir/link.txt
	sed -i -- 's/-lGL//' ./src/Plugin/ZynAddSubFX/CMakeFiles/ZynAddSubFX_vst.dir/link.txt
	make
	sudo make install
	sudo rm -rf /usr/local/lib/vst
	zynth_build_request ready
fi
#make clean
cd ../..
