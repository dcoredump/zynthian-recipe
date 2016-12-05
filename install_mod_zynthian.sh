# install_mod_zynthian.sh based on MINIBIAN
hostname zynthian
echo zynthian >/etc/hostname
sed -i -- 's/minibian/zynthian/' /etc/hosts
cat <<EOF >>~/.bashrc
export ZYNTHIAN_DIR="/zynthian"
export ZYNTHIAN_SW_DIR="${ZYNTHIAN_DIR}/zynthian-sw"
export ZYNTHIAN_UI_DIR="${ZYNTHIAN_DIR}/zynthian-ui"
export ZYNTHIAN_SYS_DIR="${ZYNTHIAN_DIR}/zynthian-sys"
export ZYNTHIAN_DATA_DIR="${ZYNTHIAN_DIR}/zynthian-data"
export ZYNTHIAN_RECIPE_DIR="${ZYNTHIAN_DIR}/zynthian-recipe"
export ZYNTHIAN_PLUGIN_DIR="${ZYNTHIAN_DIR}/zynthian-plugins/lv2/mod-lv2"
export LV2_PATH="
EOF
. ~/.bashrc
apt-get update && sudo apt-get -y upgrade && sudo apt-get -y install git aptitude sudo vim build-essential python python3 python3-cffi python3-pip jq ntpdate
apt-get purge -y libraspberrypi-doc libopts25 ntp nano joe # we use vi!
ntpdate time.fu-berlin.de
pip3 install JACK-Client

git clone https://github.com/zynthian/zynthian-sys.git
cp "${ZYNTHIAN_SYS_DIR}/etc/modules" /etc
cp "${ZYNTHIAN_SYS_DIR}/etc/udev/rules.d/*" /etc/udev/rules.d

systemctl disable raspi-config
systemctl disable dphys-swapfile
systemctl disable triggerhappy
systemctl disable cron
systemctl disable rsyslog
systemctl disable ntp
systemctl stop serial-getty@ttyAMA0.service
systemctl mask serial-getty@ttyAMA0.service
systemctl disable dhcp-client

update-rc.d -f raspi-config remove
update-rc.d -f dphys-swapfile remove
update-rc.d -f triggerhappy remove
update-rc.d -f cron remove
update-rc.d -f rsyslog remove
update-rc.d -f ntp remove

mkdir -p "${HOME}"/bin
cp $ZYNTHIAN_RECIPE_DIR/mod_zynthian/cpu-performance.sh "${HOME}/bin"
cp $ZYNTHIAN_RECIPE_DIR/mod_zynthian/bin/* "${HOME}/bin"
cp $ZYNTHIAN_RECIPE_DIR/mod_zynthian/systemd/* /etc/systemd/system
cp /boot/config.txt /boot/config.txt.orig
cp /boot/cmdline.txt /boot/cmdline.txt.orig
cp $ZYNTHIAN_RECIPE_DIR/mod_zynthian/boot/* /boot
systemctl enable jack2
systemctl enable mod-ttymidi
systemctl enable mod-host
systemctl enable mod-ui
systemctl enable performance
reboot

mkdir -p ${ZYNTHIAN_SW_DIR}
cd "${ZYNTHIAN_DIR}"
git clone https://github.com/dcoredump/zynthian-recipe.git

cd ${ZYNTHIAN_RECIPE_DIR}
sh ./install_jack2.sh
sh ./install_mod-ttymidi.sh
sh ./install_lv2_lilv.sh
sh ./install_lvtk.sh
sh ./install_mod-host.sh
sh ./install_mod-ui.sh
sh ./install_modmeter.lv2.sh
sh ./install_step-seq.sh
