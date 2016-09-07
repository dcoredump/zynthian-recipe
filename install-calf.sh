# calf
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install -y libtool-bin libfluidsynth1 libexpat-dev
git clone https://github.com/calf-studio-gear/calf.git
cd calf
sudo mv /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-2.0.pc /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-2.0.pc.tmp
sudo mv /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-3.0.pc /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-3.0.pc.tmp
sh autogen.sh
./configure --with-lv2-dir=/home/pi/zynthian/zynthian-sw/mod-lv2 --without-lash
sudo mv /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-2.0.pc.tmp /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-2.0.pc
sudo mv /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-3.0.pc.tmp /usr/lib/arm-linux-gnueabihf/pkgconfig/gtk+-3.0.pc
sed -i -- 's/, 1e-20f/, (double)1e-20f/' src/analyzer.cpp
sed -i -- 's/, 1.0f/, (double)1.0f/' src/modules_limit.cpp
make
sudo make install
make clean
cd ..
