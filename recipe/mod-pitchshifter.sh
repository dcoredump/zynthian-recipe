# mod-pitchshifter.sh
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get install -y libarmadillo-dev --no-install-recommends
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/moddevices/mod-pitchshifter.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd mod-pitchshifter
	#quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}/lv2`
	#sed -i -- "s/INSTALLATION_PATH = \$(DESTDIR)\$(INSTALL_PATH)\/\$(EFFECT_PATH)/INSTALLATION_PATH = ${quoted_ZYNTHIAN_PLUGINS_DIR}\/mod-pitchshifter/" Makefile.mk
	sed -i -- "s,-mtune=generic -msse -msse2 -mfpmath=sse,${CPU} ${FPU},g" Makefile.mk
sed -i -- "s,INSTALL_PATH = /usr/local/lib/lv2,INSTALL_PATH = ${ZYNTHIAN_PLUGINS_DIR}/lv2,g" Makefile.mk
sed -i -- "s,INSTALLATION_PATH = \$(DESTDIR)\$(INSTALL_PATH)/\$\(EFFECT_PATH\),INSTALLATION_PATH = ${ZYNTHIAN_PLUGINS_DIR}/lv2/\$\(EFFECT_PATH\),g" Makefile.mk
	make NOOPT=true
	sudo make INSTALL_PATH="${ZYNTHIAN_PLUGINS_DIR}/lv2" install
	zynth_build_request ready
	make clean
	cd ..
fi
