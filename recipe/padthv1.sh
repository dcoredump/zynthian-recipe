# padthv1.lv2
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y --no-install-recommends qt5-qmake qt5-default
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/rncbc/padthv1.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd padthv1
        libtoolize --force
        aclocal
        autoheader
        automake --force-missing --add-missing
        autoconf 
	./configure
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
	make
	sudo make install
	mv /usr/local/lib/lv2/padthv1.lv2/ /zynthian/zynthian-plugins/lv2
	zynth_build_request ready 
	make clean
	cd ..
fi
