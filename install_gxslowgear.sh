# install_gxslowgear.sh
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/moddevices/GxSlowGear.lv2.git
cd GxSlowGear.lv2/
sed -i -- 's/-msse2 -mfpmath=sse//' Makefile
sed -i -- 's/INSTALL_DIR = \/usr\/lib\/lv2/INSTALL_DIR = \/home\/\pi\/zynthian\/zynthian-plugins\/mod-lv2/' Makefile
make
sudo make install
make clean
cd ..
