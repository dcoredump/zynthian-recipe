# jacktrip
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y --no-install-recommends qt5-qmake qt5-default
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/jcacerec/jacktrip.git
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd jacktrip/src
	if [ "${build}" = "clean" ]
	then
		make clean
	fi
    sed -i -- 's/^#include "RtAudio.h"/#include "rtaudio\/RtAudio.h"/' RtAudioInterface.h
    qmake jacktrip.pro
    make release
	sudo make install
	zynth_build_request ready 
	make clean
	cd ../..
fi
