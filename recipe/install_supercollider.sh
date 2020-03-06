#!/bin/bash

sudo apt-get install -y --no-install-recommends libsamplerate0-dev libsndfile1-dev libasound2-dev libavahi-client-dev libreadline-dev libfftw3-dev libudev-dev cmake git

cd $ZYNTHIAN_PLUGINS_SRC_DIR
# supercollider
git clone --recurse-submodules https://github.com/supercollider/supercollider.git
cd supercollider
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DSUPERNOVA=OFF -DSC_ED=OFF -DSC_EL=OFF -DSC_VIM=ON -DNATIVE=ON -DSC_IDE=OFF -DNO_X11=ON -DSC_QT=OFF ..
cmake --build . --config Release --target all -- -j3
sudo cmake --build . --config Release --target install
sudo ldconfig
cd ../..
# supercollider plugins
git clone https://github.com/supercollider/sc3-plugins.git
cd sc3-plugins
git submodule init
git submodule update
mkdir build
cd build
cmake -DSC_PATH=/usr/local/include/SuperCollider -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release ..
make -j3
sudo make install
cd ../..
mkdir -p /usr/lib/SuperCollider
ln -s /usr/local/lib/SuperCollider/plugins/ /usr/lib/SuperCollider
# scsynth -u 51237 -m 131072 -a 1024 -D 0 -R 0 -l 1 -i 2 -o 2 -z 128 -c 128 -U /usr/lib/SuperCollider/plugins -b 4096 -B 127.0.0.1
