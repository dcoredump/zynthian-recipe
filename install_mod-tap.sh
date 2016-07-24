# install_mod-tap.sh
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/moddevices/tap-lv2.git
cd tap-lv2
sed -i -- 's/-mtune=generic -msse -msse2 -mfpmath=sse//' Makefile.mk
make
sudo make INSTALL_PATH=/home/pi/zynthian/zynthian-plugins/lv2
