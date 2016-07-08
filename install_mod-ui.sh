# mod-ui
cd "${HOME}/zynthian/zynthian-sw"
#sudo apt-get install python3-pip python3-dev build-essential phantomjs
sudo apt-get install python3-pip python3-dev build-essential
git clone --recursive https://github.com/moddevices/mod-ui.git
cd mod-ui
#virtualenv modui-env
#source modui-env/bin/activate
# Havn't got it running without "sudo" the next two commands :-(
#sudo apt-get purge pillow
sudo pip3 install -r requirements.txt
#wget https://github.com/aeberhardo/phantomjs-linux-armv6l/archive/master.zip
#unzip master.zip
#cd phantomjs-linux-armv6l-master
#tar xjf *.tar
#mv phantomjs-1.9.0-linux-armv6l ..
#sudo ln -s /home/pi/zynthian/zynthian-sw/mod-ui/phantomjs-1.9.0-linux-armv6l/bin/phantomjs /usr/local/bin/phantomjs
#cd ..
#rm -r phantomjs-linux-armv6l-master master.zip
# Uuuuuaaaa... bad hack!
#ln -s phantomjs-1.9.0-linux-armv6l phantomjs-1.9.0-linux-x86_64
#exit
cd utils
make
cd ..
#cp mod/host.py mod/host.py.orig
#sed -i -- '/remove -1/,+0 s/^/# /' mod/host.py
cd ..
