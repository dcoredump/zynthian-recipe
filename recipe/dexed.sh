# dexed.lv2
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y lvtk-tools
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/dcoredump/dexed.git
if [ "${?}" -ne 0 -o "${build}" = "build" ]
then
	cd dexed
	zynth_build_request clear
	git checkout native-lv2
	cd src
	make
	sudo make install
	zynth_build_request ready 
fi
#make clean
cd ../..
