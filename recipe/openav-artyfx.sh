# openav-artyfx
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y cmake
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/openAVproductions/openAV-ArtyFX.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	cd openAV-ArtyFX
	zynth_build_request clear
	quoted_ZYNTHIAN_PLUGINS_DIR=`quote_path ${ZYNTHIAN_PLUGINS_DIR}`
	sed -i -- "s/\-msse2 \-mfpmath=sse/${CPU} ${FPU}/" CMakeLists.txt
	sed -i -- "s/ lib\/lv2\// ${quoted_ZYNTHIAN_PLUGINS_DIR}\//" CMakeLists.txt
	cmake -DHAVE_NTK=OFF
	make
	sudo make install
	zynth_build_request ready
fi
#make clean
cd ..
