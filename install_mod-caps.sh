# install_mod-caps.sh
cd $ZYNTHIAN_SW_DIR
git clone https://github.com/moddevices/caps-lv2.git
cd caps-lv2
make
sudo cp -R plugins/* /home/pi/zynthian/zynthian-plugins/mod-lv2
make clean
cd ..
