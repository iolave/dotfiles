#!/bin/bash

if [ -z "$2" ]; then
	echo "usage: focus_window_or_open <window_class_name> <command>"
	return 1
fi

active=$(kdotool getactivewindow) 

found=false
for i in $(kdotool search ""); do
	name=$(kdotool getwindowclassname "$i")
	if [[ "$name" == "$1" ]]; then
		if [[ "$i" == "$active" ]]; then
			echo "[info] window already active, minimizing..."
			kdotool windowminimize $active
			exit 0
		fi

		kdotool windowactivate "$i"
		id=$i
		found=true
		exit 0
	fi
done

if [ "$found" = false ]; then
	echo "[info] window not found for $1, opening..."
	eval "$2"
fi
