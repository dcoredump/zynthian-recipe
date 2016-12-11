# sudo zynthian/zynthian-sys/scripts/zyn-wiggle
sudo apt-get update
cd $ZYNTHIAN_DIR
git clone https://github.com/dcoredump/zynthian-recipe.git
sh $ZYNTHIAN_RECIPE_DIR/install_lv2_lilv.sh # throws an error at the end - ignore it!
sh $ZYNTHIAN_RECIPE_DIR/install_mod-host.sh
sh $ZYNTHIAN_RECIPE_DIR/install_mod-ui.sh
sh $ZYNTHIAN_RECIPE_DIR/install_phantomjs.sh
sh $ZYNTHIAN_RECIPE_DIR/install_mod-sdk.sh
sudo cp $ZYNTHIAN_RECIPE_DIR/mod_zynthian/systemd/mod-host.service /etc/systemd/system
sudo sed -i -- 's/BindsTo=jack2.service/#BindsTo=jack2.service/' /etc/systemd/system/mod-host.service
sudo sed -i -- 's/After=jack2.service/#After=jack2.service/' /etc/systemd/system/mod-host.service
sudo cp $ZYNTHIAN_RECIPE_DIR/mod_zynthian/systemd/mod-ui.service /etc/systemd/system
sudo cp $ZYNTHIAN_RECIPE_DIR/mod_zynthian/systemd/mod-sdk.service /etc/systemd/system

mkdir "${HOME}"/bin
cp $ZYNTHIAN_RECIPE_DIR/mod_zynthian/bin/pedalboard* "${HOME}"/bin
chmod 755 "${HOME}"/bin/*
mkdir "${HOME}"/.pedalboards
rsync -avP $ZYNTHIAN_RECIPE_DIR/mod_zynthian/pedalboards/* "${HOME}"/.pedalboards

#
# LV2 plugins
#
sh $ZYNTHIAN_RECIPE_DIR/install_mod-mda.sh
sh $ZYNTHIAN_RECIPE_DIR/install_fluidsynth.sh
sh $ZYNTHIAN_RECIPE_DIR/install_fluidplug.sh
sh $ZYNTHIAN_RECIPE_DIR/install_mod-setbfree.sh
sh $ZYNTHIAN_RECIPE_DIR/install_zynaddsubfx.sh
sh $ZYNTHIAN_RECIPE_DIR/install_midifilter.lv2.sh
sh $ZYNTHIAN_RECIPE_DIR/install_mod-utilities.sh
sh $ZYNTHIAN_RECIPE_DIR/install_step-seq.sh
sh $ZYNTHIAN_RECIPE_DIR/install_openav-artyfx.sh
sh $ZYNTHIAN_RECIPE_DIR/install-calf.sh
sh $ZYNTHIAN_RECIPE_DIR/install_eq10q.sh
sh $ZYNTHIAN_RECIPE_DIR/install_guitarix.sh
sh $ZYNTHIAN_RECIPE_DIR/install_mclk.sh
sh $ZYNTHIAN_RECIPE_DIR/install_mod-caps.sh
sh $ZYNTHIAN_RECIPE_DIR/install_mod-distortion.sh
sh $ZYNTHIAN_RECIPE_DIR/install_mod-pitchshifter.sh
sh $ZYNTHIAN_RECIPE_DIR/install_mod-tap.sh
sh $ZYNTHIAN_RECIPE_DIR/install_sooperlooper-lv2-plugin.sh
sh $ZYNTHIAN_RECIPE_DIR/install_sosynth.sh
sh $ZYNTHIAN_RECIPE_DIR/install_fat1.sh
sh $ZYNTHIAN_RECIPE_DIR/install_gxslowgear.sh
sh $ZYNTHIAN_RECIPE_DIR/install_gxswitchlesswah.sh
sh $ZYNTHIAN_RECIPE_DIR/install_gxvintagefuzz.sh
#sh $ZYNTHIAN_RECIPE_DIR/install_gxsupertoneblender.sh
#sh $ZYNTHIAN_RECIPE_DIR/install_gxsuperfuzz.sh
#sh $ZYNTHIAN_RECIPE_DIR/install_gxvoodofuzz.sh
#sh $ZYNTHIAN_RECIPE_DIR/install_gxsupersaturator.sh
#sh $ZYNTHIAN_RECIPE_DIR/install_gxhyperion.sh
sh $ZYNTHIAN_RECIPE_DIR/install_mod-lv2-data.sh
