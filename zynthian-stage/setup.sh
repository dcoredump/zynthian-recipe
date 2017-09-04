#!/bin/bash
. /zynthian/zynthian-recipe/zynthian_envars.sh

if [ -f "${HOME}/.install-stage1" ]
then
	echo "###########"
	echo "# Stage 1 #"
	echo "###########"

	rm "${HOME}/installer.sh"
	chmod 700 "/zynthian/zynthian-recipe/zynthian-stage/setup.sh"

	mkdir -p "${ZYNTHIAN_PLUGINS_SRC_DIR}"
	mkdir -p "${ZYNTHIAN_MY_DATA_DIR}"
	mkdir -p "${ZYNTHIAN_MY_PLUGINS_DIR}"

	cd "${ZYNTHIAN_DIR}/zynthian-recipe"

	# Update System
	apt-get -y upgrade
	apt-get -y dist-upgrade
	echo "sh /zynthian/zynthian-recipe/zynthian-stage/setup.sh" >> "${HOME}/.bashrc"
	rm "${HOME}/.install-stage1"
	touch "${HOME}/.install-stage2"
	reboot
elif [ -f "${HOME}/.install-stage2" ]
then
	echo "###########"
	echo "# Stage 2 #"
	echo "###########"

	# Install required dependencies if needed
	apt-get -y install apt-utils screen
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

	rm "${HOME}/.install-stage2"
	touch "${HOME}/.install-stage3"
	reboot
elif [ -f "${HOME}/.install-stage3" ]
then
	echo "###########"
	echo "# Stage 3 #"
	echo "###########"

	# System
	apt-get -y install systemd dhcpcd-dbus avahi-daemon cpufrequtils

	# CLI Tools
	apt-get -y install raspi-config psmisc tree vim joe
	apt-get -y install p7zip-full i2c-tools

	# Tools
	apt-get -y install build-essential git swig subversion pkg-config \
	autoconf automake premake gettext intltool libtool libtool-bin cmake \
	cmake-curses-gui

	# Libraries
	apt-get -y install wiringpi libfftw3-dev libmxml-dev zlib1g-dev \
	libncurses5-dev liblo-dev libasound2-dev libffi-dev libglib2.0-dev \
	libeigen3-dev libsndfile-dev libsamplerate-dev libarmadillo-dev \
	libreadline-dev lv2-c++-tools python3-numpy-dev 

	# Python
	apt-get -y install python3 python3-dev python3-pip cython3 python3-cffi \
	python3-mpmath

	# Cleanup
	apt-get -y remove isc-dhcp-client
	apt-get -y autoremove

	# Set vim as main editor
	update-alternatives --set editor /usr/bin/vim.basic

	# Install pi-btn
	cd "${HOME}"
	mkdir -p /etc/xdg/autostart/
	git clone https://github.com/BlokasLabs/pisound.git
	cd pisound/pisound-btn
	make
	sudo make install
	rm -r /etc/xdg
	cd "${HOME}"

	#########################################################################
	# System Adjustments

	# CPU mode performance
	/usr/bin/cpufreq-set -g performance
	sed -i -- 's/GOVERNOR="ondemand"/GOVERNOR="performance"/' /etc/init.d/cpufrequtils

	# Copy config files
	cd ${ZYNTHIAN_DIR}/zynthian-recipe
	cp mod_pisound/systemd/* /etc/systemd/system
	mkdir "${HOME}/bin"
	cp -R mod_pisound/pedalboards "${HOME}/.pedalboards"

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

	#########################################################################
	# MOD-UI-System and plugins
	bash /zynthian/zynthian-recipe/recipe/update_system.sh
	cp mod_pisound/favorites.json ${ZYNTHIAN_SW_DIR}/mod-ui/dados/favorites.json
	rm "${HOME}/.install-stage3"

	history -c
	reboot
else
	echo "#########################"
	echo "# Installation finished #"
	echo "#########################"

	sed -i -- "s/sh \/zynthian\/zynthian-recipe\/zynthian-stage\/setup.sh//" "${HOME}/.bashrc"
fi
