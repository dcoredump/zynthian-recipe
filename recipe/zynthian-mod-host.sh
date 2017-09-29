# zynthian-mod-host
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get -y --no-install-recommends install libreadline-dev
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/zynthian/mod-host.git
if [ ${?} -ne 0 -o  "x${build}" != "x" ]
then
	zynth_build_request clear
	cd mod-host
        if [ "${build}" = "clean" ]
        then
                make clean
        fi
	make
	sudo make install
	zynth_build_request ready
	make clean
	cd ..
fi
