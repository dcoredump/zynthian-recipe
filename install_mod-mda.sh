# mod-mda.lv2
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/moddevices/mda-lv2.git
cd mda-lv2
./waf configure --lv2-user --lv2dir=/home/pi/zynthian/zynthian-plugins/lv2
./waf build
sudo ./waf -j1 install
