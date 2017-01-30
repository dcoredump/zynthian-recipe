# mod-pitchshifter.sh
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get install -y libarmadillo-dev
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/moddevices/mod-pitchshifter.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	cd mod-pitchshifter
	zynth_build_request clear
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}`
	sed -i -- "s/INSTALLATION_PATH = \$(DESTDIR)\$(INSTALL_PATH)\/\$(EFFECT_PATH)/INSTALLATION_PATH = ${quoted_ZYNTHIAN_PLUGINS_DIR}\/mod-pitchshifter/" Makefile.mk
	make NOOPT=true
	sudo make install
	zynth_build_request ready
fi
#make clean
cd ..
