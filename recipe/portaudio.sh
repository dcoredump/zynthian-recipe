# portaudio
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_git https://git.assembla.com/portaudio.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd portaudio/build
	cmake ..
	make
	sudo make install
	zynth_build_request ready
	make clean
	cd ../../..
fi
