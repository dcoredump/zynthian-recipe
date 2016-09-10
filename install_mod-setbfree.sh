# mod-mda.lv2
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/moddevices/setBfree.git
cd setBfree
sed -i -- 's/-msse -msse2 -mfpmath=sse //' common.mak
sed -i -- 's/^lv2dir = \$(PREFIX)\/lib\/lv2/lv2dir = \/home\/pi\/zynthian\/zynthian-plugins\/mod-lv2/' common.mak
make
sudo make install
make clean
cd ..
