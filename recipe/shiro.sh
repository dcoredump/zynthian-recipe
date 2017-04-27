# shiro
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/ninodewit/SHIRO-Plugins.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd SHIRO-Plugins
	git submodule init
	git submodule update
	make
	for i in `ls -d bin/*.lv2`
	do
		cp -R $i ${ZYNTHIAN_PLUGINS_DIR}/lv2
	done
	zynth_build_request ready
	make clean
	cd ..
fi
