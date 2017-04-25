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
	./waf configure --alsa=yes
	./waf build
	sudo ./waf install 
	if grep -q '@audio - memlock 256000' /etc/security/limits.conf
	then
		echo "memlock already set"
	else
		sudo sh -c "echo @audio - memlock 256000 >> /etc/security/limits.conf"
		echo "setting memlock"
	fi
	if grep -q '@audio - rtprio 75' /etc/security/limits.conf
	then
		echo "rtprio already set"
	else
		sudo sh -c "echo @audio - rtprio 75 >> /etc/security/limits.conf"
		echo "setting rtprio"
	fi
	./waf clean
	zynth_build_request ready
	cd ..
fi
