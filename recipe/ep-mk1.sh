# ep-mk1.lv2
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
sudo apt-get install -y --no-install-recommends puredata
cd $ZYNTHIAN_SW_DIR/plugins
mkdir ep-mk1
cd ep-mk1
wget https://github.com/MikeMorenoAudio/EP-MK1/releases/download/v2.1/EP-MK1.pd
if [ "${?}" -ne 0 -o "x${build}" != "x" ]
then
	zynth_build_request clear
	cd $ZYNTHIAN_SW_DIR/plugins/pdlv2/plugins
	mkdir ep-mk1
	cp -R template/* ep-mk1
	cp $ZYNTHIAN_SW_DIR/plugins/ep-mk1/EP-MK1.pd .
	cd $ZYNTHIAN_SW_DIR/plugins/pdlv2
	make
	sudo make install
	zynth_build_request ready 
	make clean
	cd ..
fi
