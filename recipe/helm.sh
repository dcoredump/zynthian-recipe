# heim
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
#sudo apt-get install -y libsamplerate0-dev lvtk-tools
zynth_git https://github.com/mtytel/helm.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd helm
	OIFS="$IFS"
	IFS=$'\n'
	for i in `find . -type f -name "Makefile*"`
	do
		sed -i -- "s/-msse2/${CPU} ${FPU}/" "${i}"
	done
	IFS="$OIFS"
	make
	sudo make install
	ln -s /usr/lib/lv2/helm.lv2 $ZYNTHIAN_PLUGINS_DIR/lv2
	zynth_build_request ready
	make clean
	cd ..
fi
