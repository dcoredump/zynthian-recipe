# install_mod-distortion.sh
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/moddevices/mod-distortion.git
cd mod-distortion
make
sudo make INSTALL_PATH=/home/pi/zynthian/zynthian-plugins/mod-lv2 install
make clean
cd ..
