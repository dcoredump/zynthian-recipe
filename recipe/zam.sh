# zam
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/zamaudio/zam-plugins.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd zam-plugins
#	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}/lv2`
	sed -i -- 's,PREFIX ?= /usr/local, PREFIX ?= /zynthian,g' Makefile
	sed -i -- 's,LIBDIR ?= lib,LIBDIR ?= zynthian-plugins,g' Makefile
	sed -i -- 's,-mtune=generic -msse -msse2,${CPU} ${FPU},g' Makefile.mk
	git submodule init
	git submodule update
	sed -i -- "s,-mtune=generic -msse -msse2,${CPU} ${FPU},g" Makefile.mk dpf/dgl/Makefile.mk
	sed -i -- 's,-mfpmath=sse,${CPU} ${FPU},g' Makefile.mk dpf/dgl/Makefile.mk
	make
	#for i in `ls -d ${ZYNTHIAN_PLUGINS_DIR}/lib/*.lv2`
	#do
	#	mv $i ${ZYNTHIAN_PLUGINS_DIR}/lv2
	#done
	sudo make install
	rm -r ${ZYNTHIAN_PLUGINS_DIR}/bin
	rm -r ${ZYNTHIAN_PLUGINS_DIR}/ladspa
	rm -r ${ZYNTHIAN_PLUGINS_DIR}/vst
	zynth_build_request ready
	make clean
	cd ..
fi
