#!/bin/bash

. /zynthian/zynthian-recipe/zynthian_envars.sh

cd ${ZYNTHIAN_DIR}/zynthian-recipe/recipe
# System
#sh opus.sh
#sh jack2.sh
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
sh jack_capture.sh
# Utilities
sh mclk.sh
sh modmeter.sh
sh midifilter.sh
sh step-seq.sh
sh qmidiarp.sh
# Generator
#sh fluidsynth.sh
sh fluidplug.sh
sh dxsyx.sh
sh dexed.sh
sh setbfreak.sh
#sh setbfree.sh
sh mod-mda.sh
sh rogue.sh
#sh zynaddsubfx.sh
sh remid.sh
# Div
sh eq10q.sh
sh calf.sh
sh guitarix.sh
sh mod-caps.sh
sh mod-distortion.sh
sh mod-pitchshifter.sh
sh mod-tap.sh
sh mod-utilities.sh
sh openav-artyfx.sh
sh fil4.sh
sh calf.sh
sh invada.sh
sh zam.sh
sh rkrlv2.sh
sh shiro.sh
sh bolliedelay.sh
sh midigen.sh

systemctl restart jack2
