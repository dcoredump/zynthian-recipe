#!/bin/bash
#******************************************************************************
# ZYNTHIAN PROJECT: MOD-RASPI with Pi-Sound standalone Setup Script
# 
# Setup MOD-UI on a Raspi from scratch in a completely fresh minibian-jessie
# image.
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

if [ ! -f "${HOME}/.wiggled" ]
then
    chmod 700 "/root/installer.sh"
    apt-get update
    apt-get -y --no-install-recommends install parted git sudo screen
    if [ ! -d "/zynthian" ]
    then
        mkdir /zynthian
        cd "/zynthian"
        git clone https://github.com/dcoredump/zynthian-recipe.git
    fi
    echo `date` >  ~/.wiggled
    echo ". /zynthian/zynthian-recipe/zynthian_envars.sh" >> "${HOME}/.bashrc"
    mkdir /usr/local/tmp
    echo "/usr/bin/screen -S install -L /usr/local/tmp/log /zynthian/zynthian-recipe/zynthian-stage/setup.sh" >> "${HOME}/.bashrc"
    touch "${HOME}/.install-stage1"
    sed -r -i.bak -- "s/^(.+tmpfs.+size)=[0-9]+m(.+)$/\1=128m\2/" /etc/fstab
    bash /zynthian/zynthian-recipe/rpi-wiggle.sh
fi
