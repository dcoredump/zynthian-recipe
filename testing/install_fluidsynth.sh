# fluidsynth
cd "${HOME}/zynthian/zynthian-sw"
git clone git://git.code.sf.net/p/fluidsynth/code-git fluidsynth-code-git
cd fluidsynth-code-git/fluidsynth
cmake .
make
sudo make install
