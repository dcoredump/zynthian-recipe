#!/bin/bash

export LV2_PATH=/zynthian/zynthian-plugins/lv2:/zynthian/zynthian-my-plugins/lv2
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

declare -a pedalboards

PIPE="/tmp/mod-host"

function quit {
	pkill mod-host
	pkill tail
	echo "Exiting..."
	exit 0
}

trap quit EXIT INT TERM

if [[ ! -p ${PIPE} ]]
then
	mkfifo ${PIPE}
fi
(tail -f /tmp/mod-host | /usr/local/bin/partrt run -f99 rt mod-host -i >/dev/null 2>&1 &)

pedalboards[0]="MOD-UI"
if [[ $(ps ax | grep server.py | grep -v grep | wc -l) == 0 ]]
then
	echo "Start MOD-UI"
	pedalboards[1]='Stop'
else
	echo "Stop MOD-UI"
	pedalboards[1]='Start'
fi

let i=2
for p in `ls -d /root/.pedalboards/*.pedalboard`
do
	pedalboard=`basename $p .pedalboard`
	if [[ ${pedalboard} != "default" ]]
	then
		pedalboards[$((i++))]=$pedalboard
		pedalboards[$((i++))]=""
	fi
done

while [ 42 == 42 ]
do
	choice=$(whiptail --ok-button "Choose" --cancel-button "EXIT" --default-item ${choice}--clear --title "Pedalboards" --menu "Choose pedalboard" 22 78 16 "${pedalboards[@]}" 3>&1 1>&2 2>&3)

	echo "Choosing <${choice}>"

	case ${choice} in
	"MOD-UI")
		if [[ $(ps ax | grep server.py | grep -v grep | wc -l) == 0 ]]
		then
			echo "Start MOD-UI"
			systemctl start mod-ui
			pedalboards[1]='Stop'
		else
			echo "Stop MOD-UI"
			systemctl stop mod-ui
			pedalboards[1]='Start'
		fi
		;;
	"")
		exit
		;;
	"EXIT")
		exit
		;;
	"Cancel")
		exit
		;;
	*)
		echo "remove -1" > ${PIPE}
		cat /root/.pedalboards/${choice}.pedalboard/${choice}.ttl > ${PIPE}
		whiptail --title "Pedalboard loading" --msgbox "Loading pedalboard ${choice}" 8 78
		;;
	esac
done
