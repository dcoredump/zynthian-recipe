# openav-artyfx.sh
cd "${HOME}/zynthian/zynthian-sw"
git clone https://github.com/openAVproductions/openAV-ArtyFX.git
cd openAV-ArtyFX
sed -i -- 's/\-msse2 \-mfpmath=sse/-march=armv6/' CMakeLists.txt
sed -i -- 's/ lib\/lv2\// \/home\/pi\/zynthian\/zynthian-plugins\/mod-lv2\//' CMakeLists.txt
cmake -DHAVE_NTK=OFF
sudo make install
make clean
cd ..
