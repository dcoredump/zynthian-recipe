# mod-utilities.lv2
cd "${HOME}"/zynthian/zynthian-sw
git clone https://github.com/moddevices/mod-utilities.git
cd mod-utilities
sed -i -- 's/^INSTALL_PATH = \/usr\/local\/lib\/lv2/INSTALL_PATH = \/home\/pi\/zynthian\/zynthian-plugins\/lv2/' Makefile
make
sudo make install
make clean
cd ..
