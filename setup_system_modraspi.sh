#

. /zynthian/zynthian-recipe/zynthian_envars.sh

mkdir -p "${ZYNTHIAN_PLUGINS_SRC_DIR}"
mkdir -p "${ZYNTHIAN_MY_DATA_DIR}"
mkdir -p "$7ZYNTHIAN_MY_PLUGINS_DIR}"

cd "${ZYNTHIAN_DIR}"/zynthian-recipe

# Update System
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade

# Install required dependencies if needed
apt-get -y install apt-utils
apt-get -y install sudo rpi-update htpdate parted

# Adjust System Date/Time
dpkg-reconfigure tzdata
htpdate www.isc.org

# Update Firmware
rpi-update

# System
apt-get -y install systemd dhcpcd-dbus avahi-daemon
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

#############################################################################
# System Adjustments
echo "zynthian" > /etc/hostname
sed -i -e "s/minibian/zynthian/" /etc/hosts

# PiSound
cd /root
apt-get install -y libraspberrypi-bin
wget http://blokas.io/pisound/install-pisound.sh -O install-pisound.sh
chmod +x install-pisound.sh
./install-pisound.sh
cd "${ZYNTHIAN_DIR}"/zynthian-recipe

cp mod_zynthian/boot/* /boot
sed -i -e "s/#AUDIO_DEVICE_DTOVERLAY/dtoverlay=hifiberry-dacplus/g" /boot/config.txt

# Copy "etc" config files
cp mod_zynthian//systemd/* /etc/systemd/system

systemctl daemon-reload
systemctl enable dhcpcd
systemctl enable avahi-daemon
systemctl disable raspi-config
systemctl disable cron
systemctl disable rsyslog
systemctl disable ntp
systemctl disable triggerhappy
systemctl enable cpu-performance
systemctl enable jack2
systemctl enable mod-ttymidi
systemctl enable mod-ui

cd recipe
#############################################################################
# MOD-UI-System
sh jack2.sh
sh lv2.sh
sh serd.sh
sh sord.sh
sh sratom.sh
sh lilv.sh
sh lvtk.sh
sh mod-ttymidi.sh
sh mod-host.sh
sh mod-ui.sh
sh mod-sdk.sh
sh phantomjs.sh

# LV2-Plugins
sh dxsyx.sh
sh dexed.sh
sh calf.sh
sh eq10q.sh
sh fluidsynth.sh
sh fluidplug.sh
sh midifilter.sh
sh mod-caps.sh
sh mod-distortion.sh
sh mod-mda.sh
sh mod-pitchshifter.sh
sh mod-tap.sh
sh mod-utilities.sh
sh modmeter.sh
sh openav-artyfx.sh
sh qmidiarp.sh
sh rogue.sh
sh setbfree.sh
sh step-seq.sh
sh zynaddsubfx.sh
