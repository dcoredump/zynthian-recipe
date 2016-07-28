# install_mod_zynthian.sh
sudo apt-get install -y cmake
cd "${HOME}/zynthian"
git clone https://github.com/zynthian/zyncoder.git
cd zyncoder
cmake .
make
sudo make install
