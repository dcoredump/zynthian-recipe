# rtosc
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/fundamental/rtosc.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd rtosc
	mkdir -p build
	cd build
	cmake ..
	make
	sudo make install
	zynth_build_request ready 
	make clean
	cd ../..
fi
