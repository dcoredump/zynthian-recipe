# LVtk
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/lvtk/lvtk.git
cd lvtk
./waf configure --disable-ui
./waf build
sudo ./waf install
./waf clean
cd ..
