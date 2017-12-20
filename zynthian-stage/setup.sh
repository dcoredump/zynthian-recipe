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
	echo "export LD_LIBRARY_PATH=/usr/local/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
	echo "export PYTHONPATH=\$PYTHONPATH:/usr/local/lib/python3.4/dist-packages:/usr/lib/python3/dist-packages" >> ~/.bashrc

	rm "${HOME}/installer.sh"
	chmod 700 "/zynthian/zynthian-recipe/zynthian-stage/setup.sh"

	mkdir -p "${ZYNTHIAN_PLUGINS_SRC_DIR}"
	mkdir -p "${ZYNTHIAN_MY_DATA_DIR}"
	mkdir -p "${ZYNTHIAN_MY_PLUGINS_DIR}"

	cd "${ZYNTHIAN_DIR}/zynthian-recipe"

	# Update System
	apt-get -y purge emacs emacs24 emacs24-bin-common emacs24-common
	apt-get -y autoremove
	apt-get -y upgrade
	sed -i -r -- "s/jessie/stretch/" /etc/apt/sources.list
	apt-get -y update
	apt-get -y dist-upgrade

	# Install required dependencies if needed
	apt-get -y --no-install-recommends install apt-utils screen sudo htpdate rpi-update

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
#dtoverlay=midi-uart0
disable_splash=1
disable_overscan=1
hdmi_pixel_encoding=1
framebuffer_width=1900
framebuffer_height=1280
framebuffer_depth=16
framebuffer_ignore_alpha=1
EOF
	sed -i -r -- "s/dtparam=audio=on/#dtparam=audio=on/" /boot/config.txt
	sed -i -r -- "s/gpu_mem=\d+/gpu_mem=64/" /boot/config.txt

	echo "dwc_otg.lpm_enable=0 logo.nologo vt.global_cursor_default=0 elevator=noop root=/dev/mmcblk0p2 rootfstype=ext4 fsck.repair=yes rootwait quiet" > /boot/cmdline.txt

	# Change system name
	echo "zynthian-stage" > /etc/hostname
	sed -i -e "s/minibian/zynthian-stage/" /etc/hosts
	sed -i -e "s/kivypie/zynthian-stage/" /etc/hosts

	# Update Firmware
	rpi-update

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
	sed -i -r -- "/# remove_me_after_installation/d" "${HOME}/.bashrc"

	# System
	apt-get -y --no-install-recommends install systemd avahi-daemon dhcpcd5 cpufrequtils htop tcpdump lsof xsel libts-dev libts-bin

	# CLI Tools
	apt-get -y --no-install-recommends install raspi-config psmisc tree vim joe p7zip-full i2c-tools

	# Fancy optical things
	apt-get install -y --no-install-recommends plymouth plymouth-themes
	plymouth-set-default-theme --rebuild-initrd spinner
	cp /boot/cmdline.txt /boot/cmdline.txt.bak
	echo -n "fbcon=map:10 splash plymouth.ignore-serial-consoles console=tty3 consoleblank=0 loglevel=1 " >/boot/cmdline.txt
	cat /boot/cmdline.txt.bak >>/boot/cmdline.txt
	mkinitramfs -o /boot/initramfs.gz
	echo "ramfsfile=initramfs.gz" >> /boot/config.txt
	
	# Dev-Tools
	apt-get -y --no-install-recommends install build-essential git swig subversion pkg-config \
	autoconf automake premake gettext intltool libtool libtool-bin cmake \
	cmake-curses-gui

	# Libraries
	apt-get -y --no-install-recommends install wiringpi libfftw3-dev libmxml-dev zlib1g-dev \
	libncurses5-dev liblo-dev libasound2-dev libffi-dev libglib2.0-dev \
	libeigen3-dev libsndfile-dev libsamplerate-dev libarmadillo-dev \
	libreadline-dev lv2-c++-tools

	# Python
	apt-get -y --no-install-recommends install python python3 \
	python3-pip cython3 python3-cffi python3-mpmath python3-numpy-dev
	pip3 install setuptools wheel
	mv /etc/pip.conf /etc/pip.conf.disabled # Fix for pip in stretch
	apt-get -y --no-install-recommends install python3-dev

	# PiSound button software
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

<<<<<<< HEAD
	# Add x11-fbdev and browser
	apt-get -y --no-install-recommends install xserver-xorg-video-fbdev midori xinit xserver-xorg-input-mouse xserver-xorg-input-tslib x11-xserver-utils libraspberrypi-bin xwit matchbox
	
=======
	# Add FB web browser
	apt install -y --no-install-recommends netsurf-fb ttf-dejavu-core fbset

>>>>>>> f1e82da149de5282336c124ef8984ca9a4b06b94
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
	cp etc/rc.local /etc
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

	# show boot logo
	apt-get install -y --no-install-recommends fbi ttf-dejavu-core
	systemctl disable getty@tty1.service # disable console login
	cp /zynthian/zynthian-recipe/zynthian-stage/splash.png /root
	systemctl enable splashscreen

	# tweak boot time
	mkdir -p /etc/systemd/system/networking.service.d
	cat <<EOF >/etc/systemd/system/networking.service.d/reduce-timeout.conf
[Service]
TimeoutStartSec=1
EOF

	# Setting default audio card
	if [ "${SOUNDCARD}" == "pisound" ]
        then
		systemctl enable pisound-btn
	fi

	echo "setting pisound as the default audio device"
	touch "${HOME}/.asoundrc"
	if grep -q 'pcm.!default' "${HOME}/.asoundrc"
	then
		sed -i '/pcm.!default\|ctl.!default/,/}/ { s/type .*/type hw/g; s/card .*/card 0/g; }'"${HOME}/.asoundrc"
	else
		printf 'pcm.!default {\n\ttype hw\n\tcard 1\n}\n\nctl.!default {\n\ttype hw\n\tcard 0\n}\n' >> "${HOME}/.asoundrc"
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

	# Turn back tmpfs to 16M
	if [ -e /etc/fstab.bak ]
	then
		mv /etc/fstab.bak /etc/fstab
	fi

	########################################################################
	# RT Kernel
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

	########################################################################
	# MOD-UI-System and plugins
        if (whiptail --title "Plugins" --yesno "Start plugin installation?" 8 78)
        then
		sh /zynthian/zynthian-recipe/zynthian-stage/plugins.sh
        else
                exit 1
        fi


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
	rm /var/cache/apt/archives/*.deb

	whiptail --title "Installation finished" --msgbox "A reboot is needed." 8 78
	echo "#########################"
	echo "# Installation finished #"
	echo "#########################"
	echo "... rebooting"
	sleep 5
	history -c
	reboot
fi
