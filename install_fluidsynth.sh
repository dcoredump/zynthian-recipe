# fluidsynth
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install -y cmake 
sudo chown -R pi.pi "${HOME}"/.config
git clone git://git.code.sf.net/p/fluidsynth/code-git fluidsynth-code-git
cd fluidsynth-code-git/fluidsynth
sed -i -- 's/AM_INIT_AUTOMAKE(fluidsynth, \$FLUIDSYNTH_VERSION)/AM_INIT_AUTOMAKE(fluidsynth, \$FLUIDSYNTH_VERSION)\nAC_DEFINE(DEFAULT_SOUNDFONT, "share\/soundfonts\/default.sf2", \[Default soundfont\])/' configure.ac
./autogen.sh
./configure --disable-portaudio-support --disable-ladcca --disable-lash --disable-dart --disable-coremidi --disable-coreaudio --disable-aufile-support --disable-pulse-support --disable-alsa-support --disable-dbus-support  --disable-oss-support
make
sudo make install
make clean
cd ../..
