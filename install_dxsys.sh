# dxsys
cd "${HOME}"/zynthian/zynthian-sw
sudo apt-get install -y libyaml-perl
git clone https://github.com/dcoredump/dxsyx.git
cd dxsys
make
sudo cp bin/dxsys /usr/local/bin
sudo chmod 755 /usr/local/bin/dxsys
make clean
cd ..
