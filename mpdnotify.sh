#!/usr/bin/bash
#
# mpdnotify.sh written by Ramo
#
# ------------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <ramo@goodvikings.com> wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return - Ramo
# ------------------------------------------------------------------------------
#

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

		icon=$(ls -t "$(dirname "$dir${array[4]}")"/*.{jpg,png} 2> /dev/null | head -n 1)

		notify-send "${array[1]}" "${array[2]} - ${array[3]}" -t 5000 -i "$icon"
	fi
done
