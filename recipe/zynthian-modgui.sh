# zynthian-modgui
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_DIR
zynth_git https://github.com/zynthian/zynthian-modgui.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd zynthian-modgui
	for i in *.modgui
	do
		if [ -L $ZYNTHIAN_PLUGINS_DIR/lv2/$i ]
		then
			rm $ZYNTHIAN_PLUGINS_DIR/lv2/$i
		fi
		ln -s $ZYNTHIAN_DIR/zynthian-modgui/$i $ZYNTHIAN_PLUGINS_DIR/lv2
	done
	zynth_build_request ready
fi
