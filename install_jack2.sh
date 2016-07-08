# Jack2
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/jackaudio/jack2.git
cd jack2
./waf configure
./waf build
sudo ./waf install 
cd ..
