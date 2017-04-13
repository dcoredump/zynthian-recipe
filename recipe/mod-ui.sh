# mod-ui
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y python3-pip
cd $ZYNTHIAN_SW_DIR
zynth_git_recursive https://github.com/zynthian/mod-ui.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd mod-ui
	sudo -H pip3 install -r requirements.txt
	#pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U
	#pip3 install --upgrade Pillow
	cd utils
	make
	cd ..
	zynth_build_request ready
fi
cd ..
