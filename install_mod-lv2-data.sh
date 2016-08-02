# install_mod-lv2-data.sh
mkdir -p /home/pi/zynthian/zynthian-plugins/lv2
cd "${HOME}"/zynthian/zynthian-sw
git clone https://github.com/moddevices/mod-lv2-data.git
cd "${HOME}/zynthian/zynthian-sw/mod-lv2-data"
sudo rsync -a pedalboards/* "${HOME}"/.pedalboards
sudo rsync -a presets/* "${HOME}"/.lv2
sudo rsync -a plugins/* "${HOME}"/zynthian/zynthian-plugins/lv2
sudo rsync -a plugins-fixed/* "${HOME}"/zynthian/zynthian-plugins/lv2
cd ..
rm -r mod-lv2-data
