# mod-ui
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y --no-install-recommends python3-pip
cd $ZYNTHIAN_SW_DIR
zynth_git_recursive https://github.com/moddevices/mod-ui.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd mod-ui
	patch -p0 </zynthian/zynthian-recipe/recipe/patches/mod-ui-patch.txt
	sudo -H pip3 install -r requirements.txt
	cd utils
	make
	zynth_build_request ready
	cd ../..
fi
