# install_mod_zynthian.sh
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y install git
mkdir -p "${HOME}"/zynthian/zynthian-sw
cd "${HOME}/zynthian"
git clone https://github.com/dcoredump/zynthian-recipe.git
sudo ntpdate time.fu-berlin.de

# Start optimizing here
sudo apt-get -y purge libraspberrypi-doc libopts25 ntp nano joe # we use vi!
sudo apt-get install -y vim aptitude build-essential python3 python3-cffi python3-pip jq ntpdate
sudo pip3 install JACK-Client

git clone https://github.com/zynthian/zynthian-sys.git
export ZYNTHIAN_SYS_DIR="${HOME}/zynthian/zynthian-sys"
sudo cp $ZYNTHIAN_SYS_DIR/etc/modules /etc
sudo cp $ZYNTHIAN_SYS_DIR/etc/udev/rules.d/* /etc/udev/rules.d

sudo dphys-swapfile swapoff
sudo dphys-swapfile uninstall
sudo sh -c "echo 'CONF_SWAPSIZE=0' > /etc/dphys-swapfile"

sudo systemctl disable raspi-config
sudo systemctl disable dphys-swapfile
sudo systemctl disable triggerhappy
sudo systemctl disable cron
sudo systemctl disable rsyslog
sudo systemctl disable ntp
sudo systemctl disable avahi-daemon
sudo systemctl disable dhcpcd
#sudo systemctl disable serial-getty@ttyAMA0.service

sudo update-rc.d -f raspi-config remove
sudo update-rc.d -f dphys-swapfile remove
sudo update-rc.d -f triggerhappy remove
sudo update-rc.d -f cron remove
sudo update-rc.d -f rsyslog remove
sudo update-rc.d -f ntp remove

mkdir -p "${HOME}"/bin
cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/mod_midi_autoconnect.py "${HOME}/bin"
cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/cpu-performance.sh "${HOME}/bin"
cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/bin/pedalboard "${HOME}/bin"
sudo cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/systemd/* /etc/systemd/system
sudo cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/udev/* /etc/udev/rules.d
sudo cp /boot/config.txt /boot/config.txt.orig
sudo cp /boot/cmdline.txt /boot/cmdline.txt.orig
sudo cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/boot/* /boot
sudo systemctl enable jack2
sudo systemctl enable a2jmidid
sudo systemctl enable mod-host
sudo systemctl enable mod-ui
sudo systemctl enable performance
sudo reboot
