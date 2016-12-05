# mod-sdk
cd $ZYNTHIAN_SW_DIR
apt-get install -y libjpeg9-dev libzip-dev libzip-dev
pip3 install --upgrade Pillow
git clone --recursive https://github.com/moddevices/mod-sdk.git
cd mod-sdk/utils
make
cd ../..
#cd mod-sdk
#python3 setup.py build
#sudo python3 setup.py install
#cd ..
