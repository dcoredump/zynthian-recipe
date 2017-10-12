# kivy
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt purge cython3
apt-get install libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev \
   pkg-config libgl1-mesa-dev libgles2-mesa-dev \
   python3-setuptools-git libgstreamer1.0-dev git-core \
   gstreamer1.0-plugins-{bad,base,good,ugly} \
   gstreamer1.0-{omx,alsa} python-dev
#wget https://bootstrap.pypa.io/get-pip.py
#cp /usr/bin/pip3 /usr/bin/pip3.orig
#python3 get-pip.py
#ln -s /usr/local/bin/pip /usr/bin/pip3
pip3 install --upgrade Cython==0.25.2
pip3 install git+https://github.com/kivy/kivy.git@master
