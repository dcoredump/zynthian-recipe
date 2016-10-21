# sudo zynthian/zynthian-sys/scripts/zyn-wiggle
sudo apt-get update
cd "${HOME}"/zynthian
git clone https://github.com/dcoredump/zynthian-recipe.git
sh "${HOME}"/zynthian/zynthian-recipe/install_lv2_lilv.sh # throws an error at the end - ignore it!
#sh "${HOME}"/zynthian/zynthian-recipe/install_jack2.sh    # You need jack2-git for MOD-UI
#sed -i -- 's/\/usr\/bin\/jackd -P70 -p16 -t2000 -s -dalsa -dhw:0 -r44100 -p256 -n2/#\/usr\/bin\/jackd -P70 -p16 -t2000 -s -dalsa -dhw:0 -r44100 -p256 -n2\n\t\/usr\/local\/bin\/jackd -P70 -t2000 -s -d alsa -dhw:0 -r44100 -p256 -X raw -n2/' "${HOME}"/zynthian/zynthian-ui/zynthian.sh
sed -i -- 's/\/usr\/bin\/jackd -P70 -p16 -t2000 -s -dalsa -dhw:0 -r44100 -p256 -n2/#\/usr\/bin\/jackd -P70 -p16 -t2000 -s -dalsa -dhw:0 -r44100 -p256 -n2\n\t\/usr\/bin\/jackd -P70 -t2000 -s -d alsa -dhw:0 -r44100 -p256 -X raw -n2/' "${HOME}"/zynthian/zynthian-ui/zynthian.sh
sudo chown -R pi.pi mod-ttymidi
cd mod-ttymidi
git pull
make
sudo make install
cd ..
sh "${HOME}"/zynthian/zynthian-recipe/install_mod-host.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_mod-ui.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_phantomjs.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_mod-sdk.sh
sudo cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/systemd/mod-host.service /etc/systemd/system
sudo sed -i -- 's/BindsTo=jack2.service/#BindsTo=jack2.service/' /etc/systemd/system/mod-host.service
sudo sed -i -- 's/After=jack2.service/#After=jack2.service/' /etc/systemd/system/mod-host.service
sudo cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/systemd/mod-ui.service /etc/systemd/system
sudo cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/systemd/mod-sdk.service /etc/systemd/system
mkdir "${HOME}"/bin
cp "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/bin/pedalboard* "${HOME}"/bin
chmod 755 "${HOME}"/bin/*
mkdir "${HOME}"/.pedalboards
rsync -avP "${HOME}"/zynthian/zynthian-recipe/mod_zynthian/pedalboards/* "${HOME}"/.pedalboards
#
# LV2 plugins
#
sh "${HOME}"/zynthian/zynthian-recipe/install_mod-mda.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_fluidsynth.sh
sudo ldconfig
sh "${HOME}"/zynthian/zynthian-recipe/install_fluidplug.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_mod-setbfree.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_zynaddsubfx.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_midifilter.lv2.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_mod-utilities.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_step-seq.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_openav-artyfx.sh
sh "${HOME}"/zynthian/zynthian-recipe/install-calf.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_eq10q.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_guitarix.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_mclk.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_mod-caps.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_mod-distortion.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_mod-pitchshifter.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_mod-tap.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_sooperlooper-lv2-plugin.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_sosynth.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_fat1.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_gxslowgear.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_gxswitchlesswah.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_gxvintagefuzz.sh
#sh "${HOME}"/zynthian/zynthian-recipe/install_gxsupertoneblender.sh
#sh "${HOME}"/zynthian/zynthian-recipe/install_gxsuperfuzz.sh
#sh "${HOME}"/zynthian/zynthian-recipe/install_gxvoodofuzz.sh
#sh "${HOME}"/zynthian/zynthian-recipe/install_gxsupersaturator.sh
#sh "${HOME}"/zynthian/zynthian-recipe/install_gxhyperion.sh
sh "${HOME}"/zynthian/zynthian-recipe/install_mod-lv2-data.sh
