# mod-ui
cd $ZYNTHIAN_SW_DIR
sudo ntpdate time.fu-berlin.de
git clone --recursive https://github.com/zynthian/mod-ui.git
cd mod-ui
sudo pip3 install -r requirements.txt
cd utils
make
