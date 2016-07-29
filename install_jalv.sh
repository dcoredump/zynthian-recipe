# jalv
cd "${HOME}"/zynthian/zynthian-sw
git clone https://github.com/x42/jalv.git
cd jalv
./waf configure --no-gtk --no-qt
./waf build
sudo ./waf install
cd ..
