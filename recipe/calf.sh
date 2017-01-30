# calf
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/calf-studio-gear/calf.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	cd calf
	zynth_build_request clear
	if [ RASPI = "true" ]
	then
		# <BEGIN HACK> The following lines are a f***ing b***sh*t hack - only needed if no X-dev is installed
		# Kids: Don't do this at home!!! :-)
		sudo apt-get --download-only install -y libcairo2-dev
		sudo dpkg -i --ignore-depends=libcairo2,libcairo-gobject2,libcairo-script-interpreter2,libfontconfig1-dev,libx11-dev,libxrender-dev,libxext-dev,libsm-dev,libpixman-1-dev,libxcb1-dev,libxcb-render0-dev,libxcb-shm0-dev /var/cache/apt/archives/libcairo2-dev_1.14.0-2.1+deb8u1+rpi1_armhf.deb
		sudo rm /var/cache/apt/archives/*.deb
		# <END OF HACK>
	else
		sudo apt-get install libcairo2-dev
	fi
	if [ RASPI = "true" ]
	then
		sudo mv /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-2.0.pc /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-2.0.pc.tmp
		sudo mv /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-3.0.pc /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-3.0.pc.tmp
	fi
	sh autogen.sh
	./configure --with-lv2-dir=$ZYNTHIAN_PLUGINS_DIR --exec-prefix=$ZYNTHIAN_PLUGINS_DIR --prefix=$ZYNTHIAN_PLUGINS_DIR
	if [ RASPI = "true" ]
	then
		sudo mv /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-2.0.pc.tmp /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-2.0.pc
		sudo mv /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-3.0.pc.tmp /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-3.0.pc
		sed -i -- 's/, 1e-20f/, (double)1e-20f/' src/analyzer.cpp
		sed -i -- 's/, 1.0f/, (double)1.0f/' src/modules_limit.cpp
	fi
	make
	sudo make install
	zynth_build_request ready
fi
#make clean
cd ..
