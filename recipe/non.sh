# non DAW
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y --no-install-recommends liblrdf0-dev
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git git://git.tuxfamily.org/gitroot/non/non.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd non
	./waf configure
	if [ "${build}" = "clean" ]
	then
		./waf clean
	fi
	./waf
	sudo ./waf install
	zynth_build_request ready 
	./waf clean
	cd ..
fi
