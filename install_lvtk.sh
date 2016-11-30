# LVtk
cd $ZYNTHIAN_SW_DIR
git clone https://github.com/lvtk/lvtk.git
cd lvtk
CFLAGS="NDEBUG=1" ./waf configure --disable-ui --disable-examples
./waf build
sudo ./waf install
./waf clean
cd ..
