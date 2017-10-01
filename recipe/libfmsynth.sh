# libfmsynth
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/Themaister/libfmsynth.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd libfmsynth/lv2
	sed -i -- 's/INSTALL_DIR = \/usr\/lib\/lv2/INSTALL_DIR = \/home\/pi\/zynthian\/zynthian-plugins\/mod-lv2/' GNUmakefile
	sed -i -- 's/pkg-config lvtk-plugin-1/pkg-config lvtk-plugin-2/' GNUmakefile
	sed -i -- 's/pkg-config lvtk-1/pkg-config lvtk-plugin-1/' GNUmakefile
	sed -i -- 's/LV2_GUI_CFLAGS := $(shell pkg-config --cflags lvtk-gtkui-1)//' GNUmakefile
	sed -i -- 's/LV2_GUI_LIBS := $(shell pkg-config --libs lvtk-gtkui-1)//' GNUmakefile
	sed -i -- 's/FMSYNTH_GUI_LIB := fmsynth_gui.so/FMSYNTH_GUI_LIB :=/' GNUmakefile
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
	make TUNE=arm7
	sudo make install
	zynth_build_request ready 
	make clean
	cd ../..
fi
