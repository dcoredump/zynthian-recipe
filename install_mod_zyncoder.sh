# install_zyncoder.sh
cd "${HOME}/zynthian"
git clone https://github.com/zynthian/zyncoder.git
cd zyncoder
cmake .
make
sudo make install
