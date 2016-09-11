# install_sooperlooper-lv2-plugin.sh
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/moddevices/sooperlooper-lv2-plugin.git
cd sooperlooper-lv2-plugin/sooperlooper
sed -i -- 's/INSTALLATION_PATH = \$(DESTDIR)\$(INSTALL_PATH)\/\$(PLUGIN).lv2\//INSTALLATION_PATH = \/home\/\pi\/zynthian\/zynthian-plugins\/mod-lv2\/sooperlooper.lv2/' Makefile
make
sudo make install
make clean
cd ..
