# mod-ttymidi
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get -y --no-install-recommends install libasound-dev
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/moddevices/mod-ttymidi.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd mod-ttymidi
	make
	sudo make install
	zynth_build_request ready
	make clean
	cd ..
fi
