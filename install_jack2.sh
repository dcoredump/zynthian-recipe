# Jack2
cd $ZYNTHIAN_SW_DIR
sudo apt-get install -y libasound2-dev alsa-base alsa-utils alsa-tools libsndfile1-dev
pip3 install JACK-Client
git clone https://github.com/jackaudio/jack2.git
cd jack2
./waf configure --alsa=yes
./waf build
sudo ./waf install 
./waf clean
cd ..
