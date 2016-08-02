# calf
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install -y libtool-bin libfluidsynth1
git clone https://github.com/calf-studio-gear/calf.git
cd calf
sh autogen.sh
make
sudo make install
make clean


sed -i -- 's/-msse -msse2 -mfpmath=sse //' common.mak
sed -i -- 's/^lv2dir = \$(PREFIX)\/lib\/lv2/lv2dir = \/home\/pi\/zynthian\/zynthian-plugins\/lv2/' common.mak
