# a2jmidid
cd "${HOME}/zynthian/zynthian-sw"
git clone git://repo.or.cz/a2jmidid.git
cd a2jmidid
./waf configure
./waf build
sudo ./waf install 
cd ..
