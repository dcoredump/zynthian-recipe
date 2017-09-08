# ne10
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/projectNe10/Ne10
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd Ne10
	mkdir build && cd build
	export NE10_LINUX_TARGET_ARCH="${MACHINE_HW_NAME}"
	cmake -DGNULINUX_PLATFORM=ON -DNE10_BUILD_SHARED=ON ..
	make
	cp modules/libNE10.a /usr/local/lib
	cp modules/libNE10.so.10 /usr/local/lib
	ln -s /usr/local/lib/libNE10.so.10 /usr/local/lib/libNE10.so
	cp modules/libNE10_test.so.10 /usr/local/lib
	ln -s /usr/local/lib/libNE10_test.so.10 /usr/local/lib/libNE10_test.so
	chmod 644 /usr/local/lib/libNE10*
	mkdir -p /usr/local/includes/NE10
	cp -R ../inc/* /usr/local/includes/NE10
	chmod 755 /usr/local/includes/NE10
	chmod 644 /usr/local/includes/NE10/*
	zynth_build_request ready
	make clean
	cd ..
fi
