#!/bin/bash
. /zynthian/zynthian-recipe/zynthian_envars.sh

if [ -f "${HOME}/.install-stage1" ]
then
	if (whiptail --title "Stage 1" --yesno "Start stage 1?" 8 78)
	then
		echo "###########"
		echo "# Stage 1 #"
		echo "###########"
	else
		exit 1
	fi

	# Select soundcard
	SOUNDCARD=$(whiptail --title "Soundcard" --radiolist "Choose a soundcard" 25 78 16 \
		"hifiberry-dacplus" "" on \
		"pisound" "" off \
		3>&1 1>&2 2>&3)
	echo "export SOUNDCARD=${SOUNDCARD}" >> ~/.bashrc

	rm "${HOME}/installer.sh"
	chmod 700 "/zynthian/zynthian-recipe/zynthian-stage/setup.sh"

	mkdir -p "${ZYNTHIAN_PLUGINS_SRC_DIR}"
	mkdir -p "${ZYNTHIAN_MY_DATA_DIR}"
	mkdir -p "${ZYNTHIAN_MY_PLUGINS_DIR}"

	cd "${ZYNTHIAN_DIR}/zynthian-recipe"

	# Update System
	apt-get -y purge emacs emacs24 emacs24-bin-common emacs24-common
	apt-get -y upgrade
	apt-get -y dist-upgrade

	# Install required dependencies if needed
	apt-get -y --no-install-recommends install apt-utils screen sudo htpdate whiptail

	# Add autostaic repo
	wget -q -O - http://rpi.autostatic.com/autostatic.gpg.key | apt-key add -
	wget -q -O /etc/apt/sources.list.d/autostatic-audio-raspbian.list http://rpi.autostatic.com/autostatic-audio-raspbian.list
	apt-get update

	# Adjust System Date/Time
	htpdate -t -s www.isc.org

	# Load sound firmare
	cat >> /boot/config.txt << EOF
dtoverlay=${SOUNDCARD}
dtoverlay=i2s-mmap
dtoverlay=pi3-disable-bt
# Adjust Serial Port Clock to allow MIDI baudrate 31250
#init_uart_clock=2441000
#init_uart_baud=38400
#dtparam=uart0_clkrate=3000000
dtoverlay=midi-uart0
## 1900x1200 at 16bit depth, DMT mode
#disable_overscan=1
#framebuffer_width=1900
#framebuffer_height=1200
#framebuffer_depth=16
#framebuffer_ignore_alpha=1
#hdmi_pixel_encoding=1
##hdmi_group=2
## for Waveshare Display:
#max_usb_current=1
#hdmi_group=2
#hdmi_mode=1
#hdmi_mode=87
#hdmi_cvt 1280 800 60 6 0 0 0
EOF
	echo "dwc_otg.lpm_enable=0 logo.nologo console=tty1 elevator=noop root=/dev/mmcblk0p2 rootfstype=ext4 fsck.repair=yes rootwait quiet" > /boot/cmdline.txt

	# Change system name
	echo "zynthian-stage" > /etc/hostname
	sed -i -e "s/minibian/zynthian-stage/" /etc/hosts

	# Update Firmware
	#rpi-update

	rm "${HOME}/.install-stage1"
	touch "${HOME}/.install-stage2"
	reboot
elif [ -f "${HOME}/.install-stage2" ]
then
	if (whiptail --title "Stage 2" --yesno "Start stage 2?" 8 78)
	then
		echo "###########"
		echo "# Stage 2 #"
		echo "###########"
	else
		exit 1
	fi

	sed -i -- "s/\/usr\/bin\/screen -S install \/zynthian\/zynthian-recipe\/zynthian-stage\/setup.sh.*//" "${HOME}/.bashrc"

	# System
	apt-get -y --no-install-recommends install systemd dhcpcd-dbus avahi-daemon cpufrequtils htop tcpdump lsof

	# CLI Tools
	apt-get -y --no-install-recommends install raspi-config psmisc tree vim joe p7zip-full i2c-tools

	# Dev-Tools
	apt-get -y --no-install-recommends install build-essential git swig subversion pkg-config \
	autoconf automake premake gettext intltool libtool libtool-bin cmake \
	cmake-curses-gui

	# Libraries
	apt-get -y --no-install-recommends install wiringpi libfftw3-dev libmxml-dev zlib1g-dev \
	libncurses5-dev liblo-dev libasound2-dev libffi-dev libglib2.0-dev \
	libeigen3-dev libsndfile-dev libsamplerate-dev libarmadillo-dev \
	libreadline-dev lv2-c++-tools python3-numpy-dev 

	# Python
	apt-get -y --no-install-recommends install python3 python3-dev python3-pip cython3 python3-cffi \
	python3-mpmath

	# a2jmidid for Hifiberry
	if [ "${SOUNDCARD}" == "pisound" ]
	then
		# Install pi-btn
		cd "${HOME}"
		mkdir -p /etc/xdg/autostart/
		git clone https://github.com/BlokasLabs/pisound.git
		cd pisound/pisound-btn
		make
		sudo make install
		rm -r /etc/xdg
		cd "${HOME}"
	fi

	# Cleanup
	apt-get -y remove isc-dhcp-client
	apt-get -y autoremove

	# Set vim as main editor
	update-alternatives --set editor /usr/bin/vim.basic

	#########################################################################
	# System Adjustments

	# CPU mode performance
	/usr/bin/cpufreq-set -g performance
	sed -i -- 's/GOVERNOR="ondemand"/GOVERNOR="performance"/' /etc/init.d/cpufrequtils

	# Copy config files
	cd ${ZYNTHIAN_DIR}/zynthian-recipe/zynthian-stage
	cp etc/systemd/* /etc/systemd/system
	cp -R bin "${HOME}"

	systemctl daemon-reload
	systemctl enable dhcpcd
	systemctl enable avahi-daemon
	systemctl disable raspi-config
	systemctl disable cron
	systemctl disable rsyslog
	systemctl disable ntp
	systemctl disable triggerhappy
	systemctl enable cpu-performance
	cd ${HOME}

	# Setting default audio card
	if [ "${SOUNDCARD}" == "pisound" ]
        then
		systemctl enable pisound-btn
		echo "setting pisound as the default audio device"
		touch "${HOME}/.asoundrc"
		if grep -q 'pcm.!default' "${HOME}/.asoundrc"
		then
			sed -i '/pcm.!default\|ctl.!default/,/}/ { s/type .*/type hw/g; s/card .*/card 1/g; }'"${HOME}/.asoundrc"
		else
			printf 'pcm.!default {\n\ttype hw\n\tcard 1\n}\n\nctl.!default {\n\ttype hw\n\tcard 1\n}\n' >> "${HOME}/.asoundrc"
		fi
	fi

	# Tune for jack2
	sed -i -r -- '/@audio - memlock/d' /etc/security/limits.conf
	sed -i -r -- '/@audio - rtprio/d' /etc/security/limits.conf
	echo "@audio - memlock unlimited" >> /etc/security/limits.conf
	echo "@audio - rtprio 99" >> /etc/security/limits.conf
	usermod -a -G audio root

	# enable hotplugging network - minimizes boot time
	sed -i.old-`date +%Y%m%d-%H%M%S` '/^auto lo$/!s/^auto /allow-hotplug /' /etc/network/interfaces

	# tuning kernel params
	sed -i -r -- "s/^(vm.dirty_writeback_centisecs.+)/#\1/" /etc/sysctl.conf
	echo "vm.dirty_writeback_centisecs=1500" >> /etc/sysctl.conf


#	#########################################################################
#	# RT Kernel
#	wget http://www.parasitstudio.de/zynthian/linux-firmware-image-4.9.47-rt37-v7+_4.9.47-rt37-v7+-1_armhf.deb
#	wget http://www.parasitstudio.de/zynthian/linux-headers-4.9.47-rt37-v7+_4.9.47-rt37-v7+-1_armhf.deb
#	wget http://www.parasitstudio.de/zynthian/linux-image-4.9.47-rt37-v7+_4.9.47-rt37-v7+-1_armhf.deb
#	wget http://www.parasitstudio.de/zynthian/linux-libc-dev_4.9.47-rt37-v7+-1_armhf.deb
#	dpkg -i linux-image-4.9.47-rt37-v7+_4.9.47-rt37-v7+-1_armhf.deb
#	dpkg -i linux-headers-4.9.47-rt37-v7+_4.9.47-rt37-v7+-1_armhf.deb
#	dpkg -i linux-firmware-image-4.9.47-rt37-v7+_4.9.47-rt37-v7+-1_armhf.deb
#	dpkg -i linux-libc-dev_4.9.47-rt37-v7+-1_armhf.deb
#	rm *.deb
#	echo "kernel=vmlinuz-4.9.47-rt37-v7+" >> /boot/config.txt

	#########################################################################
	# MOD-UI-System and plugins
	sh /zynthian/zynthian-recipe/zynthian-stage/plugins.sh

	cd ${ZYNTHIAN_DIR}/zynthian-recipe/zynthian-stage
	cp -R pedalboards "${HOME}/.pedalboards"
	mkdir -p ${ZYNTHIAN_SW_DIR}/mod-ui/dados
	cp favorites.json ${ZYNTHIAN_SW_DIR}/mod-ui/dados/favorites.json

	systemctl enable jack2
	systemctl enable a2jmidid
	systemctl enable mod-host
	systemctl enable mod-ui

	rm "${HOME}/.install-stage2"

	# Remove unneeded packages
	apt purge modemmanager
	apt-get -y autoremove

	whiptail --title "Installation finished" --msgbox "A reboot is needed." 8 78
	echo "#########################"
	echo "# Installation finished #"
	echo "#########################"
	echo "... rebooting"
	sleep 5
	history -c
	reboot
fi
