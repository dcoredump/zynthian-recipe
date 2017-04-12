# step-seq
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/x42/stepseq.lv2.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd stepseq.lv2
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}/lv2`
	sed -i -- "s/-msse -msse2 -mfpmath=sse/${CPU}/" Makefile
	sed -i -- "s/LV2DIR ?= \$(PREFIX)\/lib\/lv2/LV2DIR ?= $quoted_ZYNTHIAN_PLUGINS_DIR/" Makefile
	sed -i -- 's/BUILDOPENGL?=yes/BUILDOPENGL?=no/' Makefile
	sed -i -- 's/BUILDJACKAPP?=yes/BUILDJACKAPP?=no\nMOD?=yes/' Makefile
	make
	sudo make install
	make clean
	sed -i -- 's/N_NOTES ?= 8/N_NOTES ?= 16/' Makefile
	sed -i -- 's/N_STEPS ?= 8/N_STEPS ?= 16/' Makefile
	make
	sudo make install
	make clean
	sed -i -- 's/N_NOTES ?= 16/N_NOTES ?= 8/' Makefile
	sed -i -- 's/N_STEPS ?= 16/N_STEPS ?= 4/' Makefile
	make
	sudo make install
	make clean
	sed -i -- 's/N_NOTES ?= 8/N_NOTES ?= 4/' Makefile
	make
	sudo make install
	zynth_build_request ready
fi
#make clean
cd ../..
