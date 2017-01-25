# dexed.lv2
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y lvtk-tools
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/dcoredump/dexed.git
if [ ${?} -ne 0 -o  "${1}" = "build" ]
then
	cd dexed
	git checkout native-lv2
	cd src
	make
	sudo make install
fi
#make clean
cd ../..
