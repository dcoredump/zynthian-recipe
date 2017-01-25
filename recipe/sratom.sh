# sratom
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_git http://git.drobilla.net/sratom.git
if [ ${?} -ne 0 -o  "${1}" = "build" ]
then
	cd sratom
	./waf configure 
	./waf build
	sudo ./waf install
fi
#	./waf clean
cd ..
