# jack-smf-utils.sh
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
#sudo apt-get install -y --no-install-recommends libmp3lame-dev
cd $ZYNTHIAN_SW_DIR/plugins
#zynth_svn https://svn.code.sf.net/p/jack-smf-utils/code/trunk jack-smf-utils
#if [ "${?}" -ne 0 -o "x${build}" != "x" ]
#then
#	zynth_build_request clear
#	cd jack-smf-utils
#	if [ "${build}" = "clean" ]
#	then
#		make clean
#	fi
#	aclocal
#	autoconf
#	automake
#	ln -s /usr/bin/shtool .
#	./configure --with-readline 
#	make
#	sudo make install
#	zynth_build_request ready 
#	make clean
#	cd ..
#fi
wget https://downloads.sourceforge.net/project/jack-smf-utils/jack-smf-utils/1.0/jack-smf-utils-1.0.tar.gz
tar xfvz jack-smf-utils-1.0.tar.gz && rm jack-smf-utils-1.0.tar.gz
cd jack-smf-utils-1.0
./configure
make
sudo make install
make clean
cd ..

