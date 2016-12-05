# Mod-ttymidi
cd $ZYNTHIAN_SW_DIR
sudo apt-get install -y libasound-dev
git clone https://github.com/moddevices/mod-ttymidi.git
cd mod-ttymidi
make
sudo make install
cd ..
