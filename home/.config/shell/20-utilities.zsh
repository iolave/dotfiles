#!/bin/zsh

# cd to developer dir
function dev() {
	PATH_DEV="$HOME/developer"

        if [ -d "$PATH_DEV" ]; then
                cd $PATH_DEV
                return 0
        else
                echo "Directory '$PATH_DEV' not found"
                return 1
        fi
}

function ta () {
	~/.config/tmux/create-sessions.sh
	tmux attach
}

# Gets last commit hash from curent repo.
function lc() {
	hash=$(git log | head -n 1 | awk '{print $2}')
	echo $hash
}

# Connects to a vnc server using xtigervncviewer.
#
# It taks the .tigervnc file name as argument. The .tigervnc 
# must be located in $HOME/.config/tigervnc
#
# Example if myvnc.tigervnc exists:
#   $ tigervncviewer.sh myvnc
function vnc() {
	usage=""
	usage+="Usage: vnc <tigervnc_file_name>\n"
	usage+="\n"
	usage+="Example:\n"
	usage+="  $ vnc myvnc\n"

	which xtigervncviewer &> /dev/null
	if [ $? -ne 0 ]; then
		echo "error: xtigervncviewer not found"
		echo "\n$usage"
		return 1
	fi

	vnc_file="$HOME/.config/tigervnc/${1}.tigervnc"
	if [ -f "$vnc_file" ]; then
		xtigervncviewer $vnc_file
	else
		echo "error: vnc file not found"
		echo "\n$usage"
		return 1
	fi
}

function focus_window_or_open() {
	if [ -z "$2" ]; then
		echo "usage: focus_window_or_open <window_class_name> <command>"
		return 1
	fi

	active=$(kdotool getactivewindow) 

	found=false
	for i in $(kdotool search -a); do
		name=$(kdotool getwindowclassname "$i")
		if [[ "$name" == "$1" ]]; then
			if [[ "$i" == "$active" ]]; then
				echo "[info] window already active, minimizing..."
				kdotool windowminimize "$i"
				return
			fi

			kdotool windowactivate "$i"
			id=$i
			found=true
			return
		fi
	done

	if [ "$found" = false ]; then
		echo "[info] window not found for $1, opening..."
		eval "$2"
	fi
}
