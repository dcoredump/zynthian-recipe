# fluidplug
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install -y p7zip-full
git clone https://github.com/falkTX/FluidPlug.git
cd FluidPlug/
sed -i -- 's/-ffast-math -mtune=generic -msse -msse2 -mfpmath=sse -fdata-sections -ffunction-sections/-march=armv6/' Makefile.mk
sed -i -- 's/-msse -msse2/-march=armv6/' Makefile.mk
#sed -i -- 's/^DESTDIR =/DESTDIR =\/home\/pi\/zynthian\/zynthian-plugins/' Makefile
#sed -i -- 's/^PREFIX  = \/usr//' Makefile
#sed -i -- 's/\$(PREFIX)\/lib//' Makefile
cp "${HOME}"/zynthian/zynthian-recipe/FluidPlug.Makefile .
<<<<<<< HEAD
sudo make -f FluidPlug.Makefile build
=======
sudo make -f FluidPlug.Makefile install
>>>>>>> daf406a862f9931c6752f67f0eb11179ce168b37
sudo ldconfig
make distclean
cd ..
