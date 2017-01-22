# qmidiarp
cd $ZYNTHIAN_SW_DIR/plugins
apt-get install -y qt5-default autoconf automake libtool
git clone https://github.com/emuse/qmidiarp.git
git checkout lv2extui
cd qmidiarp
autoreconf -i
./configure --enable-lv2plugins --enable-qt5
make -j4
#sudo make install
cp -R *.lv2 $ZYNTHIAN_PLUGINS_DIR/lv2
cp src/.libs/qmidiarp_arp.so $ZYNTHIAN_PLUGINS_DIR/lv2/qmidiarp_arp.lv2
cp src/.libs/qmidiarp_lfo.so $ZYNTHIAN_PLUGINS_DIR/lv2/qmidiarp_lfo.lv2
cp src/.libs/qmidiarp_seq.so $ZYNTHIAN_PLUGINS_DIR/lv2/qmidiarp_seq.lv2
make clean
cd ..
