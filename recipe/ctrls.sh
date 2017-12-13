# ctrlr
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get -y --no-install-recommends install libgtk-3-dev libwebkit2gtk-4.0-dev dos2unix unzip
cd $ZYNTHIAN_SW_DIR
zynth_git_recursive https://github.com/RomanKubiak/ctrlr.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd ctrlr
	git submodule init
	git submodule update
	ln -s Source/Misc/boost Boost
	mkdir Packaging Bin
	cd Scripts
	dos2unix post-commit
	bash post-commit
	cd ctrlr/Builds/LinuxMakefile
	make
	cd $ZYNTHIAN_SW_DIR
fi
