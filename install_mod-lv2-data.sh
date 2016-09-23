# install_mod-lv2-data.sh
cd "${HOME}"/zynthian/zynthian-sw
sudo chown -R pi.pi "${HOME}"/zynthian/zynthian-plugins
git clone https://github.com/moddevices/mod-lv2-data.git
for d in `ls -d "${HOME}"/zynthian/zynthian-plugins/mod-lv2/*`
do
        B=`basename "${d}"`
        ls -d "${d}"/modgui >/dev/null 2>&1
        if [ $? != 0 ]
        then
                ls -d "${HOME}"/zynthian/zynthian-sw/mod-lv2-data/plugins/"${B}"/modgui >/dev/null 2>&1
                if [ $? = 0 ]
                then
                        rsync -avP "${HOME}"/zynthian/zynthian-sw/mod-lv2-data/plugins/"${B}"/ "${HOME}"/zynthian/zynthian-plugins/mod-lv2/"${B}"
                        continue
                fi
                ls -d "${HOME}"/zynthian/zynthian-sw/mod-lv2-data/plugins-fixed/"${B}"/modgui >/dev/null 2>&1
                if [ $? = 0 ]
                then
                        rsync -avP "${HOME}"/zynthian/zynthian-sw/mod-lv2-data/plugins-fixed/"${B}"/ "${HOME}"/zynthian/zynthian-plugins/mod-lv2/"${B}"
                        continue
                fi
                echo "No modgui found for ${B}"
        fi
done
cd "${HOME}/zynthian/zynthian-sw/mod-lv2-data"
cd ..
rm -rf mod-lv2-data
