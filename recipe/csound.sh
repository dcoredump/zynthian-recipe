# csound.sh
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
DEBIAN_VERSION=`lsb_release -a 2>/dev/null | grep "Codename:" | cut -f2`
echo "deb-src http://mirrordirector.raspbian.org/raspbian/ $DEBIAN_VERSION main contrib non-free rpi" > /etc/apt/sources.list.d/sources.list
sudo apt-get update
sudo apt-get build-dep csound
apt-get install swig python3-dev
export PYTHONPATH=/usr/local/lib
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/csound/csound.git
zynth_git https://github.com/csudo/csudo.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd csound
	cp Custom.cmake.ex Custom.cmake
	mkdir cs6make
	cd cs6make
	cmake .. -DBUILD_CSOUND_AC=OFF -DCMAKE_BUILD_TYPE="Release"
	make
	sudo make install
	sudo ldconfig
	zynth_build_request ready 
	make clean
	cd ../..
fi
