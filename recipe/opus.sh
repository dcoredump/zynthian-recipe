# opus
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_git https://git.xiph.org/opus.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd opus
	./autogen.sh
	./configure --enable-float-approx --enable-fuzzing --enable-check-asm --disable-doc --with-NE10-libraries=/usr/local/lib --with-NE10-includes=/usr/local/include/NE10
	make
	sudo make install
	zynth_build_request ready
	make clean
	cd ..
fi
