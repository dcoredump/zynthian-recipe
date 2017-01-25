# qmidiarp
. $ZYNTHIAN_DIR/zynthian-recipe/zynth_lib.sh
cd $ZYNTHIAN_SW_DIR/plugins
apt-get install -y autoconf automake libtool
#git clone https://github.com/emuse/qmidiarp.git
zynth_git https://github.com/emuse/qmidiarp.git
if [ ${?} -ne 0 ]
then
	cd qmidiarp
	git checkout lv2extui
	autoreconf -i
	./configure --prefix=/usr --exec-prefix=/zynthian/zynthian-plugins --libdir=/zynthian/zynthian-plugins --enable-buildapp=no --enable-lv2pluginuis=no
	make
	sudo make install
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

