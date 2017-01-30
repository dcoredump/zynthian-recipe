# jack2
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y libasound2-dev alsa-base alsa-utils alsa-tools libsndfile1-dev python3-pip
pip3 install JACK-Client
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/jackaudio/jack2.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	cd jack2
	zynth_build_request clear
	./waf configure --alsa=yes
	./waf build
	sudo ./waf install 
	zynth_build_request ready
fi
#./waf clean
cd ..
