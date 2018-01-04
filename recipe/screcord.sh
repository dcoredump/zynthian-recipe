# screcord
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
#sudo apt-get install -y --no-install-recommends 
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/brkl/screcord.lv2.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd screcord.lv2
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
	make
	sudo make install
	zynth_build_request ready 
	make clean
	cd ../..
fi
