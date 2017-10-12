# pgu
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get -y --no-install-recommends install python3-pygame
cd $ZYNTHIAN_SW_DIR
zynth_git_recursive https://github.com/dcoredump/pgu.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd pgu
	python3 setup.py install
	zynth_build_request ready
	cd ..
fi
