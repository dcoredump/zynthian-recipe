# dxsyx
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/rogerallen/dxsyx.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd dxsyx
	make
	sudo cp bin/dxsyx /usr/local/bin
	sudo chmod 755 /usr/local/bin/dxsyx
	zynth_build_request ready
	make clean
	cd ..
fi
