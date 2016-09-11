# install_mod-lv2-data.sh
mkdir -p /home/pi/zynthian/zynthian-plugins/mod-gui-lv2
cd "${HOME}"/zynthian/zynthian-sw
git clone https://github.com/moddevices/mod-lv2-data.git
cd "${HOME}/zynthian/zynthian-sw/mod-lv2-data"
cd ..
rm -rf mod-lv2-data
