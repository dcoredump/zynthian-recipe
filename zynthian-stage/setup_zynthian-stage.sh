#!/bin/bash

. /zynthian/zynthian-recipe/zynthian_envars.sh

mkdir -p "${ZYNTHIAN_PLUGINS_SRC_DIR}"
mkdir -p "${ZYNTHIAN_MY_DATA_DIR}"
mkdir -p "$7ZYNTHIAN_MY_PLUGINS_DIR}"

cd "${ZYNTHIAN_DIR}"/zynthian-recipe

# Update System
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
reboot

# Install required dependencies if needed
apt-get -y install apt-utils
apt-get -y install sudo rpi-update htpdate parted

# Adjust System Date/Time
htpdate -t -s www.isc.org

# Load pisound firmare
cat >> /boot/config.txt << EOF
dtoverlay=pisound
dtoverlay=i2s-mmap
dtoverlay=pi3-disable-bt
# Adjust Serial Port Clock to allow MIDI baudrate 31250
#init_uart_clock=2441000
#init_uart_baud=38400
#dtparam=uart0_clkrate=3000000
dtoverlay=midi-uart0
EOF
echo "dwc_otg.lpm_enable=0 console=tty1 elevator=deadline root=/dev/mmcblk0p2 rootfstype=ext4 fsck.repair=yes rootwait" > /boot/cmdline.txt

# Change system name
echo "zynthian-stage" > /etc/hostname
sed -i -e "s/minibian/zynthian-stage/" /etc/hosts

# Update Firmware
rpi-update
reboot

# System
apt-get -y install systemd dhcpcd-dbus avahi-daemon cpufrequtils
apt-get -y remove isc-dhcp-client

# CLI Tools
apt-get -y install raspi-config psmisc tree vim joe
update-alternatives --set editor /usr/bin/vim.basic
apt-get -y install p7zip-full i2c-tools

# Tools
apt-get -y install build-essential git swig subversion pkg-config autoconf \
automake premake gettext intltool libtool libtool-bin cmake cmake-curses-gui

# Libraries
apt-get -y install wiringpi libfftw3-dev libmxml-dev zlib1g-dev \
libncurses5-dev liblo-dev libasound2-dev libffi-dev libglib2.0-dev \
libeigen3-dev libsndfile-dev libsamplerate-dev libarmadillo-dev \
libreadline-dev lv2-c++-tools python3-numpy-dev 

# Python
apt-get -y install python3 python3-dev python3-pip cython3 python3-cffi \
python3-mpmath

# Clean
apt-get -y autoremove

# Install pi-btn
cd ~
mkdir -p /etc/xdg/autostart/
git clone https://github.com/BlokasLabs/pisound.git
cd pisound/pisound-btn
make
sudo make install
rm -r /etc/xdg

#############################################################################
# System Adjustments

# CPU mode performance
/usr/bin/cpufreq-set -g performance
sed -i -- 's/GOVERNOR="ondemand"/GOVERNOR="performance"/' /etc/init.d/cpufrequtils

# Copy config files
cd ${ZYNTHIAN_DIR}/zynthian-recipe
cp mod_pisound/systemd/* /etc/systemd/system
mkdir ~/bin
cp -R mod_pisound/pedalboards ~/.pedalboards

systemctl daemon-reload
systemctl enable dhcpcd
systemctl enable avahi-daemon
systemctl disable raspi-config
systemctl disable cron
systemctl disable rsyslog
systemctl disable ntp
systemctl disable htpdate
systemctl disable triggerhappy
systemctl enable cpu-performance
systemctl enable pisound-btn
systemctl enable jack2
systemctl enable mod-host
systemctl enable mod-ui

#############################################################################
# MOD-UI-System and plugins
bash /zynthian/zynthian-recipe/recipe/update_system.sh
cp mod_pisound/favorites.json ${ZYNTHIAN_SW_DIR}/mod-ui/dados/favorites.json
history -c
reboot
