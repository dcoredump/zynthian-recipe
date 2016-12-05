# dex.lv2
cd $ZYNTHIAN_SW_DIR
apt-get install -y lvtk-tools
git clone https://github.com/dcoredump/dexed.git
cd dexed
git checkout native-lv2
git fetch
cd src
make
sudo make install
make clean
cd ../..
