#!/bin/bash
MD_PATH="${HOME}/tmp/MOD/root-mod-duo/.lv2"

cd "${MD_PATH}"
find . -maxdepth 2 -type d -name "modgui" | while read p
do
	plugin_path_name=`echo "${p}"|cut -d"/" -f2`
	echo -n "${plugin_path_name} "
	if [ -e "${ZYNTHIAN_PLUGINS_DIR}/lv2/${plugin_path_name}" ]
	then
		echo -n "exists "
		if [ ! -e "${ZYNTHIAN_PLUGINS_DIR}/lv2/${plugin_path_name}/modgui" ]
		then
			echo "and can be gui-fied."
			if [ `grep modgui "${ZYNTHIAN_PLUGINS_DIR}/lv2/${plugin_path_name}/manifest.ttl" | wc -l` -eq 0 ]
			then
				echo "* Adding modgui.ttl to manifest.ttl"
				cp "${ZYNTHIAN_PLUGINS_DIR}/lv2/${plugin_path_name}/manifest.ttl" "${ZYNTHIAN_PLUGINS_DIR}/lv2/${plugin_path_name}/manifest.ttl.bak"
				sed -i -- 's/rdfs:seeAlso/rdfs:seeAlso <modgui.ttl>, /' "${ZYNTHIAN_PLUGINS_DIR}/lv2/${plugin_path_name}/manifest.ttl"
			fi
			echo "* copying modgui dir"
			cp -R "${plugin_path_name}"/modgui "${ZYNTHIAN_PLUGINS_DIR}/lv2/${plugin_path_name}"
			cp "${plugin_path_name}"/modgui*.ttl "${ZYNTHIAN_PLUGINS_DIR}/lv2/${plugin_path_name}/modgui.ttl"
		else
			echo "and has already a gui."
		fi
	else
		echo "does not exist"
	fi
done
