# EQ10q
cd "${HOME}"/zynthian/zynthian-gw
svn checkout svn://svn.code.sf.net/p/eq10q/code/trunk eq10q-code
cd eq10q-code
#sed -i -- 's/^INSTALLDIR = \$(DESTDIR)\/usr\/lib\/lv2\//INSTALLDIR = \/home\/pi\/zynthian\/zynthian-plugins\/mod-lv2/' Makefile
make
sudo make install
make clean
