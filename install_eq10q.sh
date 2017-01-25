# EQ10q
. $ZYNTHIAN_DIR/zynthian-recipe/zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
apt-get install -y cmake fftw-dev fftw3-dev
zynth_svn svn://svn.code.sf.net/p/eq10q/code/trunk eq10q
if [ ${?} -ne 0  -o  "${1}" = "build" ]
then
	cd eq10q
        quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}`
	sed -i -- 's/-msse -mfpmath=sse/${CPU}/' CMakeLists.txt
	sed -i -- "s/CMAKE_INSTALL_PREFIX  \"\/usr\/local\/lib\/lv2\"/CMAKE_INSTALL_PREFIX  \"$quoted_ZYNTHIAN_PLUGINS_DIR\"/" CMakeLists.txt
	sed -i -- 's/^add_subdirectory(gui)/#add_subdirectory(gui)/' CMakeLists.txt
	#sudo mv /usr/lib/arm-linux-gnueabihf/pkgconfig/glibmm-2.4.pc /usr/lib/arm-linux-gnueabihf/pkgconfig/glibmm-2.4.pc.tmp
	cmake .
	#sudo mv /usr/lib/arm-linux-gnueabihf/pkgconfig/glibmm-2.4.pc.tmp /usr/lib/arm-linux-gnueabihf/pkgconfig/glibmm-2.4.pc
	make
	sudo make install
fi
#make clean
cd ..
