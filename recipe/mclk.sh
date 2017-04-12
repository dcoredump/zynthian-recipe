# mclk
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
zynth_git https://github.com/x42/mclk.lv2.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
        zynth_build_request clear
	cd mclk.lv2
	make
	sudo make install LV2DIR=$ZYNTHIAN_PLUGINS_DIR/lv2
        sed -i -- "s/a lv2:Plugin/a lv2:Plugin, mod:MIDIPlugin/" $ZYNTHIAN_PLUGINS_DIR/lv2/mclk.lv2/manifest.ttl
        sed -i -- '2i @prefix mod: <http://moddevices.com/ns/mod#> .' manifest.ttl
	sudo cp -R modgui $ZYNTHIAN_PLUGINS_DIR/lv2/mclk.lv2
	cat <<EOF >>$ZYNTHIAN_PLUGINS_DIR/lv2/mclk.lv2/manifest.ttl
<http://gareus.org/oss/lv2/mclk>
    modgui:gui [
        modgui:resourcesDirectory <modgui> ;
        modgui:iconTemplate <modgui/icon-mclk.html> ;
        modgui:stylesheet <modgui/stylesheet-mclk.css> ;
        modgui:screenshot <modgui/screenshot-mclk.png> ;
        modgui:thumbnail <modgui/thumbnail-mclk.png> ;
        modgui:brand "x42" ;
        modgui:label "MIDI Clock" ;
        modgui:port [
            lv2:index 0 ;
            lv2:symbol "mode" ;
            lv2:name "Mode" ;
        ] ;
    ] .
EOF
	zynth_build_request ready
fi
cd ..

make clean
