# qmidiarp
cd $ZYNTHIAN_SW_DIR/plugins
apt-get install -y autoconf automake libtool
git clone https://github.com/emuse/qmidiarp.git
cd qmidiarp
git checkout lv2extui
autoreconf -i
#./configure --enable-lv2plugins --enable-qt5
./configure --prefix=/usr --exec-prefix=/zynthian/zynthian-plugins --libdir=/zynthian/zynthian-plugins --enable-buildapp=no --enable-lv2pluginuis=no
make -j4
sudo make install
make clean
cd ..
