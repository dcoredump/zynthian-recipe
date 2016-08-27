# stepseq.lv2
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/x42/stepseq.lv2.git
cd stepseq.lv2
sed -i -- 's/-msse -msse2 -mfpmath=sse //' Makefile
sed -i -- 's/LV2DIR ?= \$(PREFIX)\/lib\/lv2/LV2DIR ?= \/home\/pi\/zynthian\/zynthian-plugins\/lv2/' Makefile
sed -i -- 's/BUILDOPENGL?=yes/BUILDOPENGL?=no/' Makefile
sed -i -- 's/BUILDJACKAPP?=yes/BUILDJACKAPP?=no\nMOD?=yes/' Makefile
make
sudo make install
make clean
cd ..
