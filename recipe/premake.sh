# premake
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y --no-install-recommends
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/premake/premake-core.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd premake-core
	make -f Bootstrap.mak linux
	bin/release/premake5 test
	cd ..
	mv premake-core /usr/local
fi
