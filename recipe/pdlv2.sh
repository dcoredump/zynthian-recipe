# pdlv2
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y --no-install-recommends puredata-dev ruby-dev bundler lv2-dev lvtk-tools libgtkmm-2.4-dev lilv-utils
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/x37v/pdlv2.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd pdlv2
	git submodule init
	git submodule update
	cd libpd
        git submodule init
        git submodule update
	bundle install
	make
	sudo make install
	cd ..
	if [ "${build}" = "clean" ]
	then
		sudo make clean
	fi
	make
	zynth_build_request ready 
	cd ..
fi
