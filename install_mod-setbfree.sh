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
