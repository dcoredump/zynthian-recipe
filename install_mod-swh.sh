# install_mod-swh.sh
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install -y xsltproc
git clone https://github.com/moddevices/swh-lv2.git
cd swh-lv2
sed -i -- 's/INSTALL_DIR_REALLY=~\/.lv2\/bundles/INSTALL_DIR_REALLY=\/home\/pi\/zynthian\/zynthian-plugins\/lv2/' Makefile
make
sudo make install-user
