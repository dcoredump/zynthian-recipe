#!/bin/bash
MD_PATH="${HOME}/tmp/MOD/root-mod-duo/.lv2"

cd "${MD_PATH}"
find . -maxdepth 2 -type d -name "modgui" | while read p
do
	plugin_path_name=`echo "${p}"|cut -d"/" -f2`
	echo -n "${plugin_path_name} "
	if [ -d "${ZYNTHIAN_PLUGIN_PATH}/lv2/${plugin_path_name}" ]
	then
		echo "exists."
	else
		echo "does not exist"
	fi
done
