# jack2
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y libasound2-dev alsa-base alsa-utils alsa-tools libsndfile1-dev python3-pip
pip3 install JACK-Client
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/jackaudio/jack2.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd jack2
	./waf configure --alsa=yes --opus=no --autostart=default --doxygen=no
	./waf build
	sudo ./waf install
        sed -i -r -- '/@audio - memlock/d' /etc/security/limits.conf
        sed -i -r -- '/@audio - rtprio/d' /etc/security/limits.conf
        echo "@audio - memlock unlimited" >> /etc/security/limits.conf
        echo "@audio - rtprio 95" >> /etc/security/limits.conf
	./waf clean
	zynth_build_request ready
	cd ..
fi
