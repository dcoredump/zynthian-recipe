# lilv_python_examples
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get -y install python3
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/brunogola/lilv_python_examples
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	cd lilv_python_examples
	2to3 -w *.py
	PYTHONPATH="/usr/local/lib/python3/dist-packages" python3 lv2ls.py
	zynth_build_request ${0} ready
fi
cd ..
