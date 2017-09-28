# a2jmidid
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get -y install libdbus-1-dev
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/nick87720z/a2jmidid.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd a2jmidid
	./waf configure -p --daemon --enable-pkg-config-dbus-service-dir
	./waf build
	sudo ./waf install
	./waf clean
	zynth_build_request ready
	cd ..
fi
