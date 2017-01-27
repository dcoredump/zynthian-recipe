# phantomjs
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/fg2it/phantomjs-on-raspberry.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	mkdir -p phantomjs-raspberrypi/bin
	cp phantomjs-on-raspberry/rpi-2-3/wheezy-jessie/v2.1.1/phantomjs phantomjs-raspberrypi/bin
	rm -rf phantomjs-on-raspberry
	chmod 775 phantomjs-raspberrypi/bin/phantomjs
	sudo ln -s $ZYNTHIAN_SW_DIR/phantomjs-raspberrypi/bin/phantomjs /usr/bin/phantomjs
	sudo ln -s $ZYNTHIAN_SW_DIR/phantomjs-raspberrypi/bin/phantomjs /usr/local/bin/phantomjs
	mkdir -p $ZYNTHIAN_SW_DIR/mod-ui/phantomjs-1.9.0-linux-x86_64/bin
	ln -s $ZYNTHIAN_SW_DIR/phantomjs-raspberrypi/bin/phantomjs $ZYNTHIAN_SW_DIR/mod-ui/phantomjs-1.9.0-linux-x86_64/bin 
	zynth_build_request ${0} ready
fi
#make clean
cd ..
