# dx.lv2
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install lv2-c++-tools
git clone https://github.com/dcoredump/deeaxe7.lv2.git
cd deeaxe7.lv2/src
make
sudo make install
make clean
cd ../..
