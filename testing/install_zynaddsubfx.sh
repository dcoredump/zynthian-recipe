# zynaddsubfx
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install -y cmake libmxml-dev liblo0-dev
git clone git://git.code.sf.net/p/zynaddsubfx/code zynaddsubfx-code
cd zynaddsubfx-code
cmake .
make
sed -i -- 's/\"\${CMAKE_INSTALL_PREFIX}\/lib\/lv2\"/\"\/home\/pi\/zynthian\/zynthian-sw\/lv2\"/' cmake_install.cmake
sudo make install
