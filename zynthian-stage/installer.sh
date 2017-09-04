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
    apt-get -y install parted git
    if [ ! -d "/zynthian" ]
    then
        mkdir /zynthian
        cd "/zynthian"
        git clone https://github.com/dcoredump/zynthian-recipe.git
    fi
    echo `date` >  ~/.wiggled
    echo "/zynthian/zynthian-recipe/zynthian-stage/setup.sh" >> "${HOME}/.bashrc"
    touch "${HOME}/.install-stage1"
    sh /zynthian/zynthian-recipe/rpi-wiggle.sh
fi
