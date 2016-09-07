# install_mod-pitchshifter.sh
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install -y libarmadillo-dev libfftw3-dev python3-mpmath
git clone https://github.com/moddevices/mod-pitchshifter.git
cd mod-pitchshifter
sed -i -- 's/INSTALLATION_PATH = \$(DESTDIR)\$(INSTALL_PATH)\/\$(EFFECT_PATH)/INSTALLATION_PATH = \/home\/\pi\/zynthian\/zynthian-plugins\/mod-lv2\/mod-pitchshifter/' Makefile.mk
make NOOPT=true
sudo make install
make clean
cd ..
