# install_mod-caps.sh
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/moddevices/caps-lv2.git
cd caps-lv2
make
cp -R plugins/* /home/pi/zynthian/zynthian-plugins/lv2
