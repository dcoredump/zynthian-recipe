# EQ10q
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
apt-get install -y cmake fftw-dev fftw3-dev
zynth_svn svn://svn.code.sf.net/p/eq10q/code/trunk eq10q
if [ ${?} -ne 0  -o  "${build}" = "build" ]
then
	cd eq10q
	zynth_build_request clear
        quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}`
	sed -i -- "s/-msse -mfpmath=sse/${CPU}/" CMakeLists.txt
	sed -i -- "s/CMAKE_INSTALL_PREFIX  \"\/usr\/local\/lib\/lv2\"/CMAKE_INSTALL_PREFIX  \"$quoted_ZYNTHIAN_PLUGINS_DIR\"/" CMakeLists.txt
	sed -i -- 's/^add_subdirectory(gui)/#add_subdirectory(gui)/' CMakeLists.txt
	#sudo mv /usr/lib/arm-linux-gnueabihf/pkgconfig/glibmm-2.4.pc /usr/lib/arm-linux-gnueabihf/pkgconfig/glibmm-2.4.pc.tmp
	cmake .
	#sudo mv /usr/lib/arm-linux-gnueabihf/pkgconfig/glibmm-2.4.pc.tmp /usr/lib/arm-linux-gnueabihf/pkgconfig/glibmm-2.4.pc
	make
	zynth_build_request ready
	sudo make install
fi
#make clean
cd ..
