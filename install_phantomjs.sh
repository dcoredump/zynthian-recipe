# phantomjs
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install -y libfontconfig
git clone https://github.com/fg2it/phantomjs-on-raspberry.git
mkdir -p phantomjs-raspberrypi/bin
cp phantomjs-on-raspberry/wheezy-jessie/v2.1.1/phantomjs phantomjs-raspberrypi/bin
rm -rf phantomjs-on-raspberry
chmod 775 phantomjs-raspberrypi/bin/phantomjs
mkdir -p /home/pi/zynthian/zynthian-sw/mod-ui/phantomjs-1.9.0-linux-x86_64/bin
sudo ln -s /home/pi/zynthian/zynthian-sw/phantomjs-raspberrypi/bin/phantomjs /usr/bin/phantomjs
sudo ln -s /home/pi/zynthian/zynthian-sw/phantomjs-raspberrypi/bin/phantomjs /usr/local/bin/phantomjs
<<<<<<< HEAD
sudo ln -s /home/pi/zynthian/zynthian-sw/phantomjs-raspberrypi/bin/phantomjs /home/pi/zynthian/zynthian-sw/mod-ui/phantomjs-1.9.0-linux-x86_64/bin 
=======
mkdir -p /home/pi/zynthian/zynthian-sw/mod-ui/phantomjs-1.9.0-linux-x86_64/bin
ln -s /home/pi/zynthian/zynthian-sw/phantomjs-raspberrypi/bin/phantomjs /home/pi/zynthian/zynthian-sw/mod-ui/phantomjs-1.9.0-linux-x86_64/bin
>>>>>>> 3de9a723300d06ec8c8ce511767e9b60af019d1f
