# fluidplug
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install -y p7zip-full
git clone https://github.com/falkTX/FluidPlug.git
cd FluidPlug/
sed -i -- 's/-ffast-math -mtune=generic -msse -msse2 -mfpmath=sse -fdata-sections -ffunction-sections/-march=armv6/' Makefile.mk
sed -i -- 's/-msse -msse2/-march=armv6/' Makefile.mk
sed -i -- 's/^DESTDIR =/DESTDIR =\/home\/pi\/zynthian\/zynthian-plugins/' Makefile
sed -i -- 's/^PREFIX  = \/usr//' Makefile
sed -i -- 's/\$(PREFIX)\/lib//' Makefile
make
cp "${HOME}"/zynthian/zynthian-recipe/FluiPlug.Makefile .
sudo make -f FluidPlug.Makefile install
sudo ldconfig
make clean
cd ..
