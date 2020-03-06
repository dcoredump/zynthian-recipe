#!/bin/bash

sudo apt-get install -y --no-install-recommends g++ ruby ruby-dev pkg-config git build-essential libjack-jackd2-dev libsndfile1-dev libasound2-dev libavahi-client-dev libicu-dev libreadline6-dev libfftw3-dev libxt-dev libudev-dev cmake libboost-dev libqwt-qt5-dev libqt5scintilla2-dev libqt5svg5-dev qt5-qmake qt5-default qttools5-dev qttools5-dev-tools qtdeclarative5-dev libqt5webkit5-dev qtpositioning5-dev libqt5sensors5-dev libqt5opengl5-dev qtmultimedia5-dev libffi-dev curl python erlang-base

cd $ZYNTHIAN_PLUGINS_SRC_DIR
git clone https://github.com/samaaron/sonic-pi.git
cd sonic-pi/app/gui/qt/
gem install fast_osc ffi rugged
../../server/ruby/bin/i18n-tool.rb -t
cp utils/ruby_help.tmpl utils/ruby_help.h
../../server/ruby/bin/qt-doc.rb -o utils/ruby_help.h
lrelease lang/*.ts
mkdir build && cd build
cmake ..
make -j3
cd $ZYNTHIAN_PLUGINS_SRC_DIR
