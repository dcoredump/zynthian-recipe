# install_mod_zynthian.sh
sudo apt-get update && sudo apt-get -y upgrade
sudo aptitude purge ntp
sudo apt-get install -y vim aptitude build-essential git python3 python3-cffi python3-pip jq
sudo pip3 install JACK-Client
mkdir -p "${HOME}"/zynthian/zynthian-sw
cd "${HOME}/zynthian"
git clone https://github.com/zynthian/zynthian-sys.git
git clone https://github.com/dcoredump/zynthian-recipe.git

sudo dphys-swapfile swapoff
sudo dphys-swapfile uninstall
sudo sh -c "echo 'CONF_SWAPSIZE=0' > /etc/dphys-swapfile"

export ZYNTHIAN_SYS_DIR="${HOME}/zynthian/zynthian-sys"
sudo cp $ZYNTHIAN_SYS_DIR/etc/modules /etc
sudo cp $ZYNTHIAN_SYS_DIR/etc/udev/rules.d/* /etc/udev/rules.d

sudo systemctl disable raspi-config
sudo systemctl disable dphys-swapfile
sudo systemctl disable triggerhappy
sudo systemctl disable cron
sudo systemctl disable rsyslog
sudo systemctl disable ntp
sudo systemctl disable avahi-daemon
sudo systemctl disable dhcpcd

sudo update-rc.d -f raspi-config remove
sudo update-rc.d -f dphys-swapfile remove
sudo update-rc.d -f triggerhappy remove
sudo update-rc.d -f cron remove
sudo update-rc.d -f rsyslog remove
sudo update-rc.d -f ntp remove

cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/mod_midi_autoconnect.py "${HOME}"
cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/cpu-performance.sh "${HOME}"
sudo cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/systemd/* /etc/systemd/system
sudo cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/udev/* /etc/udev/rules.d
sudo systemctl enable jack2
sudo systemctl enable a2jmidid
sudo systemctl enable mod-host
sudo systemctl enable mod-ui
sudo systemctl enable performance
