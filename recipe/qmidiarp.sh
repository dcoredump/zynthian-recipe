# qmidiarp
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
apt-get install -y autoconf automake libtool
zynth_git https://github.com/dcoredump/qmidiarp.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd qmidiarp
	git checkout lv2extui
	autoreconf -i
	./configure --prefix=/usr --exec-prefix=/zynthian/zynthian-plugins --libdir=/zynthian/zynthian-plugins --enable-buildapp=no --enable-lv2pluginuis=no
	make
	sudo make install
	cp -R qmidiarp_arp.lv2/modgui* /zynthian/zynthian-plugins/lv2/qmidiarp_arp.lv2
	cp -R qmidiarp_lfo.lv2/modgui* /zynthian/zynthian-plugins/lv2/qmidiarp_lfo.lv2
	cp -R qmidiarp_seq.lv2/modgui* /zynthian/zynthian-plugins/lv2/qmidiarp_seq.lv2
	zynth_build_request ready
fi
#make clean
cd ..

exit 0
######################
add https://github.com/dcoredump/dexed.lv2 0
add http://gareus.org/oss/lv2/stepseq#s8n8 1
add https://git.code.sf.net/p/qmidiarp/arp 2
add http://gareus.org/oss/lv2/modmeter 3
connect effect_0:audio_out effect_3:in
connect effect_1:midiout effect_2:MidiIn
connect effect_2:MidiOut effect_0:midi_in
param_set 1 grid_1_1 1
param_set 2 CH_IN 1

