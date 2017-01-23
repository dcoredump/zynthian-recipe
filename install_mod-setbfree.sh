# mod-mda.lv2
cd $ZYNTHIAN_PLUGINS_SRC_DIR
git clone https://github.com/dcoredump/setBfree.git
cd setBfree
sed -i -- 's/-msse -msse2 -mfpmath=sse/-pipe -mcpu=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -mvectorize-with-neon-quad -funsafe-loop-optimizations -funsafe-math-optimizations/g' common.mak
sed -i -- 's/^lv2dir = \$(PREFIX)\/lib\/lv2/lv2dir = \/zynthian\/zynthian-plugins\/lv2/' common.mak
make -j 4 ENABLE_LV2=1 ENABLE_JACK=0
sudo make install
make clean
cd ..


exit 0
############################
drawbarsupper0
drawbarsupper1
drawbarsupper2
drawbarsupper3
drawbarsupper4
drawbarsupper5
drawbarsupper6
drawbarsupper7
drawbarsupper8
drawbarslower0
drawbarslower1
drawbarslower2
drawbarslower3
drawbarslower4
drawbarslower5
drawbarslower6
drawbarslower7
drawbarslower8
drawbarspedals0
drawbarspedals1=0-8
vibrato=0-5 (v1 | v2 | v3 | c1 | c2 | c3)
vibratoupper=0,1
vibratolower=0,1
perc=0,1
percvol=0,1 (normal | high | hi or soft   | low  | lo)
percspeed=0,1 (fast | high | hi or slow | low  | lo)
percharm=0,1 (second | 2nd | low  | lo or third  | 3rd | high | hi)
overdrive=0,1
rotaryspeed=0,2 (tremolo | fast | high | hi or chorale | slow | low  | lo or stopped | stop | zero | break)
reverbmix=0.0-1.0
keysplitpedals=0-127
keysplitlower=0-127
trssplitpedals=-127-127
trssplitlower=-127-127
trssplitupper=-127-127
transpose=-127-127
transposeupper=-127-127
transposelower=-127-127
transposepedals=-127-127
