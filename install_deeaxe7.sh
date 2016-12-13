# dx.lv2
<<<<<<< HEAD
cd "${HOME}/zynthian/zynthian-sw"
=======
cd $ZYNTHIAN_SW_DIR
sudo apt-get install lv2-c++-tools
>>>>>>> fd23e8777c04542931313ce9473a6390e0230307
git clone https://github.com/dcoredump/deeaxe7.lv2.git
cd deeaxe7.lv2/src
make
sudo make install
make clean
cd ../..
