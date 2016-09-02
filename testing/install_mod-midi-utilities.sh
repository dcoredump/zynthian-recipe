# install_mod-midi-utilities.sh
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/moddevices/mod-midi-utilities.git
cd mod-midi-utilities
sed -i -- 's/\$(DESTDIR)\/usr\/lib\/lv2/\/home\/pi\/zynthian\/zynthian-plugins\/lv2/' Makefile
make
sudo make install
make clean
cd ..
