# fluidplug
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/falkTX/FluidPlug.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd FluidPlug
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}`
	sed -i -- "s/-ffast-math -mtune=generic -msse -msse2 -mfpmath=sse -fdata-sections -ffunction-sections/${CPU} ${FPU}/" Makefile.mk
	sed -i -- "s/-msse -msse2/${CPU} ${FPU}/" Makefile.mk
	sed -i -- 's/^PREFIX  = \/usr//' Makefile
	sed -i -- 's/\$(PREFIX)\/lib//' Makefile
	make
	sudo make DESTDIR=${ZYNTHIAN_PLUGINS_DIR} install
	zynth_build_request ready
	make distclean
fi
cd ..
