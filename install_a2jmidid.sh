# a2jmidid
sudo apt-get install -y libasound2-dev
cd "${HOME}/zynthian/zynthian-sw"
git clone git://repo.or.cz/a2jmidid.git
cd a2jmidid
./waf configure
./waf build
sudo ./waf install 
cd ..
