# mod-host
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get -y install libreadline-dev
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/moddevices/mod-host.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd mod-host
	make
	sudo make install
	zynth_build_request ready
fi
#	make clean
cd ..
