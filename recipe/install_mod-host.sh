# Mod-Host
cd "${HOME}"/zynthian/zynthian-sw
sudo apt-get install -y libreadline-dev
git clone https://github.com/moddevices/mod-host.git
cd mod-host
#patch -p1 <"${HOME}/zynthian/zynthian-recipe/mod-host.patch.txt"
make
sudo make install
cd ..
