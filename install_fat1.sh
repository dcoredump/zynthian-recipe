# fat1.lv2
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/x42/fat1.lv2.git
cd fat1.lv2
sed -i -- 's/-msse -msse2 -mfpmath=sse //' Makefile
sed -i -- 's/LV2DIR ?= \$(PREFIX)\/lib\/lv2/LV2DIR ?= \/home\/pi\/zynthian\/zynthian-plugins\/mod-lv2/' Makefile
make MOD=1
sudo make MOD=1 install
make clean
cd ..
