#! /bin/bash

Clock(){
	DATE=$(date "+%m.%d.%y")
	TIME=$(date "+%I:%M")

	echo -e -n "\uf073 ${DATE} \uf017 ${TIME}"
}

ActiveWindow(){
	echo -n $(xdotool getwindowfocus getwindowname)
}

Battery() {
	BATTACPI=$(acpi --battery)
	BATPERC=$(echo $BATTACPI | cut -d, -f2 | tr -d '[:space:]')

	if [[ $BATTACPI == *"100%"* ]]
	then
		echo -e -n "\uf00c $BATPERC"
	elif [[ $BATTACPI == *"Discharging"* ]]
	then
		BATPERC=${BATPERC::-1}
		if [ $BATPERC -le "10" ]
		then
			echo -e -n "\uf244"
		elif [ $BATPERC -le "25" ]
		then
			echo -e -n "\uf243"
		elif [ $BATPERC -le "50" ]
		then
			echo -e -n "\uf242"
		elif [ $BATPERC -le "75" ]
		then
			echo -e -n "\uf241"
		elif [ $BATPERC -le "100" ]
		then
			echo -e -n "\uf240"
		fi
		echo -e " $BATPERC%"
	elif [[ $BATTACPI == *"Charging"* && $BATTACPI != *"100%"* ]]
	then
		echo -e "\uf0e7 $BATPERC"
	elif [[ $BATTACPI == *"Unknown"* ]]
	then
		echo -e "$BATPERC"
	fi
}

Wifi(){
	readarray -d\  WIFI <<<$(iwconfig wlp2s0 | tr -d '\n' | sed -ne "s/wlp2s0    IEEE 802.11  ESSID:\"\(.*\)\".*Link Quality=\([0-9]*\)\/.*/\1 \2/p")
	WIFI[1]=$((( ${WIFI[1]} * 100 / 70 )))
	echo -e "\uf1eb ${WIFI[0]} ${WIFI[1]}%"
}

Sound(){
	NOTMUTED=$( amixer sget Master | grep "\[on\]" )
	if [[ ! -z $NOTMUTED ]] ; then
		VOL=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master) | sed 's/%//g')
		if [ $VOL -ge 85 ] ; then
			echo -e "\uf028 ${VOL}%"
		elif [ $VOL -ge 50 ] ; then
			echo -e "\uf027 ${VOL}%"
		else
			echo -e "\uf026 ${VOL}%"
		fi
	else
		echo -e "\uf026 M"
	fi
}

Workspaces(){
	FOCUSED=$(bspc query -D -d focused --names)
	WORKSPACES=(1 2 3 4 5 6 7 8 9 0)
	for i in {0..9}; do
		if [ ${WORKSPACES[$i]} == $FOCUSED ]; then
			WORKSPACES[$i]="  [$FOCUSED]  "
		fi
	done
	echo -e ${WORKSPACES[@]}
	
}




while true; do
	echo -e "%{l}$(Workspaces)" "%{c}" "%{r}[ $(Wifi) ]  [ $(Battery) ]  [ $(Sound) ]  [ $(Clock) ]"
	sleep 1
done
