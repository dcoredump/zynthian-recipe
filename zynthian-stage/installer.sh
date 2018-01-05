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
    #chmod 700 "/root/installer.sh"
    apt-get update
    apt-get -y --no-install-recommends install parted git sudo screen apt-utils
    if [ ! -x /usr/bin/whiptail ]
    then
        apt-get -y --no-install-recommends install whiptail
    fi
    if [ ! -d "/zynthian" ]
    then
        mkdir /zynthian
        cd "/zynthian"
        git clone https://github.com/dcoredump/zynthian-recipe.git
    fi
    echo ". /zynthian/zynthian-recipe/zynthian_envars.sh" >> "${HOME}/.bashrc"
    echo 'if [ `screen -ls | wc -l` -lt 3 ] # remove_me_after_installation' >> "${HOME}/.bashrc"
    echo "then # remove_me_after_installation" >> "${HOME}/.bashrc"
    echo "    /usr/bin/screen -L -S install /zynthian/zynthian-recipe/zynthian-stage/setup.sh # remove_me_after_installation" >> "${HOME}/.bashrc"
    echo "fi # remove_me_after_installation" >> "${HOME}/.bashrc"
    touch "${HOME}/.install-stage1"
    sed -r -i.bak -- "s/^(.+tmpfs.+size)=[0-9]+m(.+)$/\1=128m\2/" /etc/fstab
    echo `date` >  ~/.wiggled
    bash /zynthian/zynthian-recipe/rpi-wiggle.sh
fi
