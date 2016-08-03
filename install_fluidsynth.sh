# fluidsynth
cd "${HOME}/zynthian/zynthian-sw"
sudo apt-get install -y cmake
sudo chown -R pi.pi "${HOME}"/.config
git clone git://git.code.sf.net/p/fluidsynth/code-git fluidsynth-code-git
cd fluidsynth-code-git/fluidsynth
cmake .
make
sudo make install
make clean
cd ../..
