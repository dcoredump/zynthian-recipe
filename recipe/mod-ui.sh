# mod-ui
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y python3-pip
cd $ZYNTHIAN_SW_DIR
zynth_git_recursive https://github.com/zynthian/mod-ui.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	cd mod-ui
	sudo -H pip3 install -r requirements.txt
	cd utils
	make
	cd ..
	zynth_build_request ${0} ready
fi
cd ..
