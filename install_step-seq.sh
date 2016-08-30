# stepseq.lv2
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/x42/stepseq.lv2.git
cd stepseq.lv2
sed -i -- 's/-msse -msse2 -mfpmath=sse //' Makefile
sed -i -- 's/LV2DIR ?= \$(PREFIX)\/lib\/lv2/LV2DIR ?= \/home\/pi\/zynthian\/zynthian-plugins\/lv2/' Makefile
sed -i -- 's/BUILDOPENGL?=yes/BUILDOPENGL?=no/' Makefile
sed -i -- 's/BUILDJACKAPP?=yes/BUILDJACKAPP?=no\nMOD?=yes/' Makefile
sed -i -- 's/N_NOTES ?= 16/N_STEPS ?= 16/' Makefile
make
sudo make install
make clean
sed -i -- 's/N_NOTES ?= 8/N_STEPS ?= 16/' Makefile
sudo make install
make clean
sed -i -- 's/N_NOTES ?= 8/N_STEPS ?= 8/' Makefile
sudo make install
make clean
sed -i -- 's/N_NOTES ?= 4/N_STEPS ?= 16/' Makefile
sudo make install
make clean
sed -i -- 's/N_NOTES ?= 4/N_STEPS ?= 8/' Makefile
sudo make install
make clean
cd ..
