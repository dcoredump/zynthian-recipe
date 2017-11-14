# rtaudio
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y --no-install-recommends shtool
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/thestk/rtaudio
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd rtaudio
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
    ./autogen.sh
    ./configure --with-jack
    make
	sudo make install
	zynth_build_request ready 
	make clean
	cd ..
fi
