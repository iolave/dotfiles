#!/bin/bash

if [ ! -d ~/.tmux/plugins/tpm ]; then
	echo "info: installing tpm"
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

uuid=$(uuidgen)
mkdir -p "/tmp/$uuid"
tmux new-session -d -s "tmp" -c "/tmp/$uuid" &> /dev/null
tmux new-session -d -s "home" -c "$HOME" &> /dev/null

# get all directories in the ~/developer/git directory
git_path="$HOME/developer/git/"
for dir in $(find ~/developer/git -mindepth 2 -maxdepth 2 -type d); do
	# replace the git path of the directory with the name of the directory
	# e.g. /Users/iolave/Developer/git/iolave -> iolave
    name=$(echo "$dir" | sed "s#$git_path##")
    tmux new-session -d -s "$name" -c "$dir" &> /dev/null
done

exit 0
