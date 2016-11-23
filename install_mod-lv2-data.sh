# install_mod-lv2-data.sh
cd $ZYNTHIAN_PLUGINS_SRC_DIR
git clone https://github.com/moddevices/mod-lv2-data.git
for d in `ls -d $ZYNTHIAN_PLUGINS_DIR/lv2/*`
do
	B=`basename "${d}"`
	ls -d "${d}"/modgui >/dev/null 2>&1
	if [ $? != 0 ]
	then
			ls -d $ZYNTHIAN_PLUGINS_SRC_DIR/mod-lv2-data/plugins/"${B}"/modgui >/dev/null 2>&1
			if [ $? = 0 ]
			then
					rsync -avP $ZYNTHIAN_PLUGINS_SRC_DIR/mod-lv2-data/plugins/"${B}"/ $ZYNTHIAN_PLUGINS_DIR/lv2/"${B}"
					continue
			fi
			ls -d $ZYNTHIAN_PLUGINS_SRC_DIR/mod-lv2-data/plugins-fixed/"${B}"/modgui >/dev/null 2>&1
			if [ $? = 0 ]
			then
					rsync -avP $ZYNTHIAN_PLUGINS_SRC_DIR/mod-lv2-data/plugins-fixed/"${B}"/ $ZYNTHIAN_PLUGINS_DIR/lv2/"${B}"
					continue
			fi
			echo "No modgui found for ${B}"
	fi
done
cd "$ZYNTHIAN_PLUGINS_SRC_DIR/mod-lv2-data"
cd ..
rm -rf mod-lv2-data
