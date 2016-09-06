# Jack2
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install -y libasound2-dev libdbus-1-dev
git clone https://github.com/jackaudio/jack2.git
cd jack2
./waf configure --dbus --enable-pkg-config-dbus-service-dir
./waf build
sudo ./waf install 
./waf clean
cd ..
