# helm
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
#sudo apt-get install -y libxinerama-dev libxcursor-dev libcurl4-openssl-dev
sudo apt-get install -y libxinerama-dev libcurl4-openssl-dev
zynth_git https://github.com/mtytel/helm.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd helm
	#export DEBCXXFLAGS="${CXXFLAGS}"
	#find . -type f -name "Makefile*" -exec sed -i -- "s/-msse2/${CPU} ${FPU}/" {} \;
	sed -i -- "s/-march=armv8-a -mtune=cortex-a53/${CPU} ${FPU}/" Makefile
	make lv2
	sudo make install
	ln -s /usr/lib/lv2/helm.lv2 $ZYNTHIAN_PLUGINS_DIR/lv2
	zynth_build_request ready
	make clean
	cd ..
fi
