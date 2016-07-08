# midifilter.lv2
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/x42/midifilter.lv2.git
cd midifilter.lv2
sed -i -- 's/-msse -msse2 -mfpmath=sse //' Makefile
sed -i -- 's/lib\/lv2//' Makefile
make
sudo make install PREFIX=/home/pi/zynthian/zynthian-plugins/lv2
