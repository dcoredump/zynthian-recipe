# generic_fluidplug_masterpiece
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd GenericFluidPlug
	wget http://rkhive.com/new/new_banks/masterpiece.zip -O /tmp/masterpiece.zip
	mkdir /tmp/masterpiece
	unzip /tmp/masterpiece.zip -d /tmp/masterpiece
	rm /tmp/masterpiece.zip
	export MODSDK=/zynthian/zynthian-sw/mod-sdk
	perl ./genericfluidplug  -boxy-style=wood4 -knob-style=black /tmp/masterpiece/Masterpiece.sf2 /zynthian/zynthian-sw/plugins/Masterpiece $ZYNTHIAN_PLUGINS_DIR
	cd /zynthian/zynthian-sw/plugins/Masterpiece
	make install
	rm -r /tmp/masterpiece
	zynth_build_request ready
fi
cd ..
