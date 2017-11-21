# jmess
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
#sudo apt-get install -y --no-install-recommends qt5-qmake qt5-default
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/jcacerec/jmess-jack.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd jmess-jack/jmess/src
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
	qmake jmess.pro
	make release
	sudo make install
	zynth_build_request ready 
	make clean
	cd ../../..
fi
