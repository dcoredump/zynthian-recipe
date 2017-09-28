# invada
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
sudo apt-get install -y invada-studio-plugins-lv2 --no-install-recommends
ln -s /usr/lib/lv2/invada.lv2 $ZYNTHIAN_PLUGINS_DIR/lv2
