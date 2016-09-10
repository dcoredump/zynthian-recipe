sudo apt-get update
cd "${HOME}"/zynthian
git clone https://github.com/dcoredump/zynthian-recipe.git
sh "${HOME}"/zynthian/zynthian-recipe/install_lv2_lilv.sh # throws an error at the end - ignore it!
sh "${HOME}"/zynthian/zynthian-recipe/install_jack2.sh    # You need jack2-git for MOD-UI
sed -i -- 's/\/usr\/bin\/jackd -P70 -p16 -t2000 -s -dalsa -dhw:0 -r44100 -p256 -n2/#\/usr\/bin\/jackd -P70 -p16 -t2000 -s -dalsa -dhw:0 -r44100 -p256 -n2\n\t\/usr\/local\/bin\/jackd -P70 -t2000 -s -d alsa -dhw:0 -r44100 -p256 -X raw -n2/' "${HOME}"/zynthian/zynthian-ui/zynthian.sh
sudo chown -R pi.pi mod-ttymidi
cd mod-ttymidi
git pull
make
sudo make install
cd ..
sh "${HOME}"/zynthian/zynthian-recipe/install_mod-host.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_mod-ui.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_phantomjs.sh
sudo cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/systemd/mod-host.service /etc/systemd/system
sudo cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/systemd/mod-ui.service /etc/systemd/system
