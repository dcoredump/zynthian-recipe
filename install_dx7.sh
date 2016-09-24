# dx.lv2
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/dcoredump/dx7.lv2.git
cd dx7.lv2/src
make
sudo make install
make clean
cd ../..
