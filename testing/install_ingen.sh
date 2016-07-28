# InGen
sudo apt-get update
sudo apt-get install -y libboost1.55-dev libglibmm-2.4-dev libwebkit-dev libgtkmm-2.4-dev
cd "${HOME}/zynthian/zynthian-sw"
git clone --recursive http://git.drobilla.net/cgit.cgi/drobillad.git/ lad
cd lad/suil
./waf configure
./waf build
sudo ./waf install
cd ../raul
./waf configure
./waf build
sudo ./waf install
cd ../ganv
./waf configure
./waf build
sudo ./waf install
cd ../ingen
#./waf configure --no-gui --no-client 
./waf configure
./waf build
sudo ./waf install
cd ../..
