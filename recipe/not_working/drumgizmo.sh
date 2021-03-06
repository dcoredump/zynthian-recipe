# serd
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
cd $ZYNTHIAN_SW_DIR
sudo apt-get install -y qt5-default
zynth_git_recursive http://git.drumgizmo.org/drumgizmo.git
if [ ${?} -ne 0 -o  "${build}" = "build" ]
then
	zynth_build_request clear
	cd drumgizmo
	git submodule init
	git submodule update
	./autogen.sh
	./configure --enable-lv2 --disable-input-dummy --disable-input-test --disable-input-jackmidi --disable-input-midifile --disable-output-dummy --disable-output-jackaudio --disable-output-alsa --disable-output-wavfile --with-lv2dir=$ZYNTHIAN_PLUGINS_DIR/lv2
	make
	sudo make install
	zynth_build_request ready
fi
make clean
cd ..
exit 0
#
        DrumGizmo gizmo(settings, *oe.get(), *ie.get());
        settings.drumkit_file.store(kitfile);
        Settings settings;
        settings.disk_cache_enable = false;

bool DrumGizmoPlugin::ConfigStringIO::set(std::string config_string)

