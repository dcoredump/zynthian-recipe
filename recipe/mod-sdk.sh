# mod-sdk
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_git_recursive https://github.com/moddevices/mod-sdk.git
if [ ${?} -ne 0 -o  "${1}" = "build" ]
then
	cd mod-sdk/utils
	make
	cd ..
fi
cd ..
