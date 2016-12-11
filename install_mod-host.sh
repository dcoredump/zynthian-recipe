# Mod-Host
cd $ZYNTHIAN_SW_DIR
sudo apt-get install -y libreadline-dev
git clone https://github.com/moddevices/mod-host.git
cd mod-host
#patch -p1 <"${HOME}/zynthian/zynthian-recipe/mod-host.patch.txt"
make -j 4
sudo make install
make clean
