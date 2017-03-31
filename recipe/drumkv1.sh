# serd
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
sudo apt-get install -y qt5-default
zynth_git_recursive http://git.code.sf.net/p/drumkv1/code drumkv1-git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	ln -s code drumkv1-git
	cd drumkv1-git
	./autogen.sh
	./configure --enable-lv2 --enable-lv2-external-ui=no --enable-lv2-ui-idle=no --enable-lv2-ui-show=no --enable-jack=no --enable-alsa-midi=no --prefix=/zynthian/zynthian-plugins/lv2
	make
	sudo make install
	mv $ZYNTHIAN_PLUGINS_DIR/lv2/lib/lv2/drumkv1.lv2 $ZYNTHIAN_PLUGINS_DIR/lv2
	zynth_build_request ready
fi
make clean
cd ..
