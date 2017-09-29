# linuxsampler
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
sudo apt-get install -y --no-install-recommends subversion libtool flex bison libsqlite3-dev
zynth_svn https://svn.linuxsampler.org/svn/libgig/trunk libgig
if [ "${?}" -ne 0 ]
then
	changed="1"
fi
zynth_svn https://svn.linuxsampler.org/svn/liblscp/trunk liblscp
if [ "${?}" -ne 0 ]
then
	changed="1"
fi
zynth_svn https://svn.linuxsampler.org/svn/linuxsampler/trunk linuxsampler
if [ "${?}" -ne 0 ]
then
	changed="1"
fi
if [ "x${changed}" = "x1" -o "x${build}" != "x" ]
then
	zynth_build_request clear
	# libgig
	cd libgig
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
	libtoolize --force
	aclocal
	autoheader
	automake --force-missing --add-missing
	autoconf 
	./configure
	make
	sudo make install
	# liblscp
	cd ../liblscp
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
	libtoolize --force
	aclocal
	autoheader
	automake --force-missing --add-missing
	autoconf 
	./configure
	make
	sudo make install
	# linuxsampler
	cd ../linuxsampler
	libtoolize --force
	aclocal
	autoheader
	automake --force-missing --add-missing
	autoconf
	./configure --enable-max-voices=21 --enable-max-streams=64 --enable-stream-min-refill=4096 --enable-refill-streams=2 --enable-stream-max-refill=131072 --enable-stream-size=262144 --disable-asm --enable-subfragment-size=64 --enable-eg-min-release-time=0.001 --enable-eg-bottom=0.0025 --enable-max-pitch=2 --enable-preload-samples=65536
	cd src/scriptvm
	yacc -o parser parser.y
	cd ../..
	if [ ${RASPI} ]
	then
		rm -rf rpi_linuxsampler_patch
		#git clone https://github.com/coolder/rpi_linuxsampler_patch.git
		#patch -p0 <rpi_linuxsampler_patch/atomic.h.diff 
		#cd src/common/
		#patch <../../rpi_linuxsampler_patch/RTMath.cpp.diff
		#cd ../..
		git clone https://github.com/steveb/rpi_linuxsampler_patch.git
		if ! patch -R -p1 --dry-run <rpi_linuxsampler_patch/linuxsampler-arm.patch
		then
			patch -p1 <rpi_linuxsampler_patch/linuxsampler-arm.patch
		fi
	fi
	make
	sudo make install
	sudo ln -s /usr/local/lib/lv2/linuxsampler.lv2 "${ZYNTHIAN_PLUGINS_DIR}/lv2"
	zynth_build_request ready 
	make clean
	cd ../..
fi
