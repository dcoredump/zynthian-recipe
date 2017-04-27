# opus
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_git git clone https://git.xiph.org/opus.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd opus
	./configure
	make
	sudo make install
	zynth_build_request ready
	make clean
	cd ..
fi
