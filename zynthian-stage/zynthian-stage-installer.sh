#!/bin/bash
#******************************************************************************
# ZYNTHIAN PROJECT: MOD-RASPI with Pi-Sound standalone Setup Script
# 
# Setup MOD-UI on a Raspi from scratch in a completely fresh minibian-jessie
# image.
# No need for nothing else. Only run the script twice, following the next
# instructions:
#
# 1. Run first time: ./setup_mod_pisound.sh
# 2. Reboot: It should reboot automaticly after step 1
# 3. Run second time: ./setup_mod_pisound.sh
# 4. During installation another reboot apears - start ./setup_mod_pisound.sh
#    a third time.
# 5. ... and for updating the firmware the next reboot apears - start
#    ./setup_mod_pisound.sh again.
# 6. Take a good beer, sit down and relax ... ;-)
# 
# Copyright (C) Holger Wirtz <dcoredump@googlemail.com>
#
#******************************************************************************
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or any later version.
#
# 
#******************************************************************************

if [ ! -f ~/.wiggled ]; then
    apt-get update
    apt-get -y install parted
    echo `date` >  ~/.wiggled
    ./rpi-wiggle.sh
else
    apt-get upgrade -y
    apt-get -y install apt-utils
    apt-get -y install sudo git screen
    if [ ! -d "/zynthian/zynthian-recipe" ]; then
        if [ ! -d "/zynthian" ]; then
            mkdir /zynthian
        fi
        cd /zynthian
        git clone https://github.com/dcoredump/zynthian-recipe.git
    fi
fi

cd /zynthian/zynthian-recipe
./zynthian-stage/setup_zynthian-stage.sh

