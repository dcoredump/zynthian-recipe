# generic_fluidplug_frieden
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd GenericFluidPlug
	export MODSDK=/zynthian/zynthian-sw/mod-sdk
	wget http://bug.parasitstudio.de/tmp/frieden-synths.sf2.zip
	unzip frieden-synths.sf2.zip && rm frieden-synths.sf2.zip
	perl ./genericfluidplug  -boxy-style=wood1 -knob-style=blue frieden-synths.sf2 /zynthian/zynthian-sw/plugins/Frieden $ZYNTHIAN_PLUGINS_DIR/lv2
	rm frieden-synths.sf2
	cd /zynthian/zynthian-sw/plugins/Frieden
	make install
	zynth_build_request ready
	make clean
	cd ..
fi
