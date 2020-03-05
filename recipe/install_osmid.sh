#!/bin/bash

cd $ZYNTHIAN_PLUGINS_SRC_DIR
git clone https://github.com/llloret/osmid.git
cd osmid
mkdir build && cd build
cmake ..
make -j3
sudo make install
cd ../..
