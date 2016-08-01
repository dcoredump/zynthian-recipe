# guitarix.lv2
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install -y gettext intltool libgettextpo-dev libglib2.0-dev libglibmm-2.4-dev libfftw3-dev libeigen3-dev libsndfile-dev
git clone http://git.code.sf.net/p/guitarix/git guitarix-git
cd guitarix-git/trunk
./waf configure --no-lv2-gui --lv2-only --disable-sse --lv2dir=/home/pi/zynthian/zynthian-plugins/lv2 --no-avahi --no-bluez --no-ladspa --no-faust 
./waf build
sudo ./waf install
./waf clean
cd ../..
