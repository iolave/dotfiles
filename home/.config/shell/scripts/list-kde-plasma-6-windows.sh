#!/bin/bash
for i in $(kdotool search ""); do
	name=$(kdotool getwindowclassname "$i")
	echo "$i: $name"
done

