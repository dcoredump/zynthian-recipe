# kivy
# https://kivy.org/docs/installation/installation-rpi.html
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get purge cython3
sudo apt-get install -y --no-install-recommends pkg-config \
   libgstreamer1.0-dev git-core \
   gstreamer1.0-plugins-{bad,base,good,ugly} \
   gstreamer1.0-{omx,alsa} python3-dev libraspberrypi-dev \
   libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev \
   pkg-config libgl1-mesa-dev libgles2-mesa-dev libmtdev-dev \
   python3-setuptools-git python3-wheel
pip3 install --upgrade Cython==0.25.2
cd $ZYNTHIAN_SW_DIR
zynth_git https://github.com/kivy/kivy
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
        zynth_build_request clear
	#pip3 install git+https://github.com/kivy/kivy.git@master
	cd kivy
	#sed -i -- "s/c_options\[.use_egl.\] = False/c_options\[\'use_egl\'\] = True/" setup.py
	python3 setup.py build && python3 setup.py install
        zynth_build_request ready
	python3 setup.py clean
        cd ..
fi
# https://kivy.org/docs/guide/environment.html
# sdl2, pygame, x11, egl_rpi
#KIVY_BCM_DISPMANX_ID=2 KIVY_WINDOW=egl_rpi SDL_FBDEV=/dev/fb0 python3 main.py 
