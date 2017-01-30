# mod-sdk
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y python3-pip
cd $ZYNTHIAN_SW_DIR
zynth_git_recursive https://github.com/moddevices/mod-sdk.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd mod-sdk/utils
	make
	zynth_build_request ready
	cd ..
fi
cd ..
