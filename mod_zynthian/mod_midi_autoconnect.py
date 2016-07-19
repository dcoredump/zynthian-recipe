#!/usr/bin/python3
# -*- coding: utf-8 -*-
#********************************************************************
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
#********************************************************************

import sys
import os
import jack
import re

hw_black_list = [
	"Midi Through"
]
#hw_black_list = []

jclient=jack.Client("mod_midi_autoconnect")

hw_out=jclient.get_ports(is_output=True, is_physical=True, is_midi=True)

if len(hw_out)==0:
	hw_out=[]

for hw in hw_out:
	for i,v in enumerate(hw_black_list):
		if v in str(hw):
			hw_out.remove(hw)

	for hw in hw_out:
		m=re.match(r"jack.MidiPort\(\'(.+)\'\)",str(hw))
		if(m.group(1)):
			print(" Executing: /usr/local/bin/jack_alias \'"+m.group(1)+"\' ttymidi:MIDI_in")
			os.system("/usr/local/bin/jack_alias \'"+m.group(1)+"\' ttymidi:MIDI_in")
