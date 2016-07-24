# mod-ui
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install python3-pip python3-dev build-essential
git clone --recursive https://github.com/moddevices/mod-ui.git
cd mod-ui
sudo pip3 install -r requirements.txt
cd utils
make
cd ..
