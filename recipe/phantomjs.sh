# phantomjs
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
if [ "${build}" = "build" -o ! -f phantomjs-raspberrypi/bin/phantomjs ]
then
	zynth_git https://github.com/fg2it/phantomjs-on-raspberry.git
	if [ ${?} -ne 0 ]
	then
		zynth_build_request clear
		mkdir -p phantomjs-raspberrypi/bin
		cp phantomjs-on-raspberry/rpi-2-3/wheezy-jessie/v2.1.1/phantomjs phantomjs-raspberrypi/bin
		rm -rf phantomjs-on-raspberry
		chmod 775 phantomjs-raspberrypi/bin/phantomjs
		rm -rf $ZYNTHIAN_SW_DIR/mod-ui/phantomjs-1.9.0-linux-x86_64/bin
		mkdir -p $ZYNTHIAN_SW_DIR/mod-ui/phantomjs-1.9.0-linux-x86_64/bin
		ln -s $ZYNTHIAN_SW_DIR/phantomjs-raspberrypi/bin/phantomjs $ZYNTHIAN_SW_DIR/mod-ui/phantomjs-1.9.0-linux-x86_64/bin 
		ln -s $ZYNTHIAN_SW_DIR/phantomjs-raspberrypi/bin/phantomjs /usr/local/bin
		zynth_build_request ready
	fi
fi
