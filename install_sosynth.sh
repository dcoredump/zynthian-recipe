# sosynth.sh
cd "${HOME}"/zynthian/zynthian-gw
git clone https://github.com/jeremysalwen/So-synth-LV2
cd So-synth-LV2
sed -i -- 's/^INSTALLDIR = \$(DESTDIR)\/usr\/lib\/lv2\//INSTALLDIR = \/home\/pi\/zynthian\/zynthian-plugins\/lv2/' Makefile
make
sudo make install
make clean
