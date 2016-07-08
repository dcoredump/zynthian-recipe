# phantomjs
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/fg2it/phantomjs-on-raspberry.git
cd phantomjs-on-raspberry/jessie/b483dd673a1ca589ff10c5f73dfea1e43bfa3225
sudo dpkg -i phantomjs_2.0.0_armhf.deb 
cd "${HOME}/zynthian/zynthian-sw"
rm -rf phantomjs-on-raspberry
mkdir -p "${HOME}/zynthian/zynthian-sw/mod-ui/phantomjs-1.9.0-linux-x86_64/bin"
sudo ln -s /usr/bin/phantomjs "${HOME}/zynthian/zynthian-sw/mod-ui/phantomjs-1.9.0-linux-x86_64/bin"
sudo ln -s /usr/local/bin/phantomjs /usr/bin/phantomjs


# phantomjs
#cd "${HOME}/zynthian/zynthian-sw"
#git clone https://github.com/piksel/phantomjs-raspberrypi.git
#ln -s "${HOME}/zynthian/zynthian-sw/phantomjs-raspberrypi" "${HOME}/zynthian/zynthian-sw/mod-ui/phantomjs-1.9.0-linux-x86_64"
#sudo ln -s "${HOME}/zynthian/zynthian-sw/phantomjs-raspberrypi/bin/phantomjs" /usr/local/bin
#sudo ln -s /usr/local/bin/phantomjs /usr/bin

#sudo apt-get install -y libicu-dev libssl-dev gperf bison flex
#cd "${HOME}/zynthian/zynthian-sw"
#git clone https://github.com/ariya/phantomjs.git
#cd phantomjs
##python3 build.py --skip-configure-qtwebkit --skip-qtwebkit --skip-configure-qtbase --skip-qtbase
#python3 build.py -j4
