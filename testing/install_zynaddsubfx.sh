# zynaddsubfx.lv2
cd "${HOME}/zynthian/zynthian-sw"
wget http://download.gna.org/zyn/zyn-1.tar.bz2
tar xjf zyn-1.tar.bz2 && rm zyn-1.tar.bz2
cd zyn-1
make LV2_INSTALL_PATH="${HOME}"/zynthian/zynthian-plugins/lv2
sudo make install LV2_INSTALL_PATH="${HOME}"/zynthian/zynthian-plugins/lv2
make clean
cd ..
