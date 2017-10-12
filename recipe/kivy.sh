# kivy
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get purge cython3
sudo apt-get install -y --no-install-recommends pkg-config \
   libgstreamer1.0-dev git-core \
   gstreamer1.0-plugins-{bad,base,good,ugly} \
   gstreamer1.0-{omx,alsa} python3-dev libraspberrypi-dev \
   python3-setuptools-git
pip3 install --upgrade Cython==0.25.2
#pip3 install git+https://github.com/kivy/kivy.git@master
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/kivy/kivy
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
        zynth_build_request clear
	cd kivy
	sed -i -- "s/c_options\['use_egl'\] = .+/c_options\['use_egl'\] = True/"
	python3 setup.py build
        zynth_build_request ready
        cd ..
fi
#KIVY_BCM_DISPMANX_ID=2 python3 main.py 
