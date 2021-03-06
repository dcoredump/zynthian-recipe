# serd
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_git_recursive http://git.drobilla.net/serd.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd serd
	./waf configure 
	./waf build
	sudo ./waf install
	zynth_build_request ready
	./waf clean
	cd ..
fi
