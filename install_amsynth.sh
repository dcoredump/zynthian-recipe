# amsynth
cd $ZYNTHIAN_SW_DIR
git clone https://github.com/amsynth/amsynth.git
cd amsynth
sh autogen.sh
LV2_LIBS=`pkg-config --libs lv2` LV2_CFLAGS=`pkg-config --cflags lv2` ./configure CXXFLAGS='-std=c++11' --without-gui --without-jack --without-alsa --without-oss --without-vst --without-sndfile --with-lv2
make
sudo make install
make clean
cd ../..
