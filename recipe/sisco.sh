# sisco.lv2
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y --no-install-recommends libghc-cairo-dev libghc-pango-dev
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/x42/sisco.lv2.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
	make submodules
	sed -i -- "s/-msse -msse2 -mfpmath=sse/${CPU}/" Makefile
	make
	sudo make install PREFIX=/usr/local
	zynth_build_request ready 
	make clean
	cd ..
fi
