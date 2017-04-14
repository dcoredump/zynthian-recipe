# distrho
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
sudo apt-get install -y premake ladspa-sdk libxcursor-dev
zynth_git https://github.com/DISTRHO/DISTRHO-Ports.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
        zynth_build_request clear
	cd DISTRHO-Ports/
	./scripts/premake-update.sh linux
	for i in `find . -name "*.make"`
	do
		sed -i -- "s/-mtune=generic -msse -msse2//" $i
		sed -i -- "s/-mfpmath=sse//" $i
	done
	sed -i -- "s/\$(MAKE) -C dexed\/LV2/#\$(MAKE) -C dexed\/LV2/" ports/Makefile
	sed -i -- "s/\$(MAKE) -C juce-demo-plugin\/LV2/#\$(MAKE) -C juce-demo-plugin\/LV2/" ports/Makefile
	sed -i -- "s/\$(MAKE) -C pitchedDelay\/LV2/#\$(MAKE) -C pitchedDelay\/LV2/" ports/Makefile
	sed -i -- "s/\$(MAKE) -C LUFSMeter\/LV2/#\$(MAKE) -C LUFSMeter\/LV2/" ports/Makefile
	sed -i -- "s/\$(MAKE) -C LUFSMeter\/LV2-Multi/#\$(MAKE) -C LUFSMeter\/LV2-Multi/" ports/Makefile
	make lv2
	sudo cp -R bin/lv2/* $ZYNTHIAN_PLUGINS_DIR/lv2
	make clean
	zynth_build_request ready
	cd ..
fi
