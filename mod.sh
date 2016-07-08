#!/bin/bash
#******************************************************************************
# MOD Raspi based on Zynthian
#******************************************************************************
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# For a full copy of the GNU General Public License see the LICENSE.txt file.
# 
#******************************************************************************

ZYNTHIAN_DIR="/home/pi/zynthian"

#------------------------------------------------------------------------------
# Some Functions
#------------------------------------------------------------------------------

function scaling_governor_performance() {
	for cpu in /sys/devices/system/cpu/cpu[0-9]*; do 
		sudo echo -n performance | tee $cpu/cpufreq/scaling_governor
	done
}

function jack_audio_start() {
	# Start jack-audio server
	sudo /usr/bin/jackd -P70 -p512 -t2000 -s -dalsa -dhw:0 -r44100 -p256 -n2
	sleep 1
}

function jack_audio_stop() {
	# Stop jack-audio server
	sudo killall jackd
}

function a2j_midi_start() {
	# Start alsa2jack midi router
	while [ 1 ]; do 
		sudo /usr/bin/a2jmidid --export-hw
		sleep 1
	done
}

function mod-ui_start() {
	# Start mod-ui
	while [ 1 ]; do 
		sudo MOD_PHANTOM_BINARY=/usr/bin/phantomjs LV2_PATH="/home/pi/zynthian/zynthian-plugins/lv2" MOD_DEV_ENVIRONMENT=0 /home/pi/zynthian/zynthian-sw/mod-ui/server.py
		sleep 1
	done
}

function mod-host_start() {
	# Start mod-host
	sudo LV2_PATH="/home/pi/zynthian/zynthian-plugins/lv2" /usr/local/bin/mod-host 
	sleep 2
}

function mod-host_stop() {
	# Stop mod-host
	sudo killall mod-host
}

function mod-ui_stop() {
	# Stop mod-ui
	mod_ui=`ps ax | grep server.py | grep -v grep | cut -d" " -f2`
	if [ $mod_ui ]
	then
		kill -15 $mod_ui
	fi
}

function a2j_midi_stop() {
	# Stop alsa2jack midi router
	sudo killall a2jmidid
}

function ttymidi_start() {
	# Start ttymidi (MIDI UART interface)
	while [ 1 ]; do 
		sudo /usr/local/bin/ttymidi -s /dev/ttyAMA0 -b 38400
		sleep 1
	done
}

function ttymidi_stop() {
	sudo killall ttymidi
}

function mod-ui_stop() {
	a2j_midi_stop
	mod-ui_stop
	mod-host_stop
	ttymidi_stop
	jack_audio_stop
}

#------------------------------------------------------------------------------
# Main Program
#------------------------------------------------------------------------------
set -x

cd $ZYNTHIAN_DIR/zynthian-ui
sudo service zynthian stop
scaling_governor_performance
jack_audio_start &
ttymidi_start &
sleep 1
a2j_midi_start &
sleep 1
mod-host_start
mod-ui_start &
#------------------------------------------------------------------------------
