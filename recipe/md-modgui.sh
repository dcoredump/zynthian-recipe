#!/bin/bash
MD_PATH="${HOME}/tmp/MOD/root-mod-duo"
sudo apt-get -y --no-install-recommends install unzip
mkdir -p "${HOME}/tmp/MOD/root-mod-duo"
cd "${HOME}/tmp/MOD/root-mod-duo/"
wget http://www.parasitstudio.de/modgui.zip
unzip "modgui.zip" && rm "modgui.zip"

cd "${MD_PATH}"
find . -maxdepth 2 -type d -name "modgui" | while read p
do
	plugin_path_name=`echo "${p}"|cut -d"/" -f2`
	case ${plugin_path_name} in
		"calf-*")
			orig_plugin_path_name=${p}
			;;
		"rkr-*")
			orig_plugin_path_name=${p}
			;;
		*)
			orig_plugin_path_name=${plugin_path_name}
			;;
	esac
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
				sudo cp "${ZYNTHIAN_PLUGINS_DIR}/lv2/${plugin_path_name}/manifest.ttl" "${ZYNTHIAN_PLUGINS_DIR}/lv2/${plugin_path_name}/manifest.ttl.bak"
				sudo sed -i -- 's/rdfs:seeAlso/rdfs:seeAlso <modgui.ttl>, /' "${ZYNTHIAN_PLUGINS_DIR}/lv2/${plugin_path_name}/manifest.ttl"
			fi
			echo "* copying modgui dir"
			sudo cp -R "${orig_plugin_path_name}"/modgui "${ZYNTHIAN_PLUGINS_DIR}/lv2/${plugin_path_name}"
			sudo cp "${orig_plugin_path_name}"/modgui*.ttl "${ZYNTHIAN_PLUGINS_DIR}/lv2/${plugin_path_name}/modgui.ttl"
		else
			echo "and has already a gui."
		fi
	else
		echo "does not exist"
	fi
done
rm -rf cd "${HOME}/tmp/MOD/root-mod-duo/"
cd /zynthian/zynthian-recipe
