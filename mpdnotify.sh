#!/usr/bin/bash

dir="/home/ramo/Music/"

while :
do
	output=$(mpc -f "%title%\n%artist%\n%album%\n%file%" current --wait)
	if [ $? -eq 1 ]
	then
		sleep 5
	else
		i=1
		while read -r line; do
			array[$i]="$line"
			(( i++ ))
		done <<< "$output"

		file=$(ls -t "$(dirname "$dir${array[4]}")"/*.{jpg,png} 2> /dev/null | head -n 1)

		notify-send "${array[1]}" "${array[2]} - ${array[3]}" -t 5000 -i "$file"
	fi
done
