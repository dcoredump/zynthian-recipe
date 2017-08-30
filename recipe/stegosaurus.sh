# stegosaurus
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/thunderox/stegosaurus.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd stegosaurus
	./waf configure --lv2-user --lv2dir=$ZYNTHIAN_PLUGINS_DIR/lv2
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
	./waf build
	./waf install
	zynth_build_request ready 
	./waf clean
	cd ..
fi
