# generic_fluidplug_piano
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
apt-get install -y unrar
cd $ZYNTHIAN_SW_DIR/plugins
zynth_build_request clear
cd GenericFluidPlug
export MODSDK=/zynthian/zynthian-sw/mod-sdk
wget http://flstudiomusic.com/files/soundfonts/25-piano-sf.rar
unrar x 25-piano-sf.rar && rm 25-piano-sf.rar
mv "25 Piano Soundfonts" "Soundfonts"
find Soundfonts -type f | while read i
do
	plugin_name=`basename "${i}"`
	plugin_filename=`echo ${plugin_name} | tr " " "_"`
	mv "${i}" "Soundfont/${plugin_filename}"
	perl ./genericfluidplug  -boxy-style=wood2 -knob-style=black "Soundfont/${plugin_filename}" /zynthian/zynthian-sw/plugins/"${plugin_filename}" $ZYNTHIAN_PLUGINS_DIR/lv2
	cd /zynthian/zynthian-sw/plugins/"${plugin_filename}"
	make install
	make clean
	cd "${ZYNTHIAN_SW_DIR}/plugins/GenericFluidPlug"
	rm "Soundfonts/${plugin_filename}"
done
zynth_build_request ready
rm -r "Soundfonts"
cd ..
