#!/bin/bash

# get all directories in the ~/Developer/git directory
git_path="$HOME/Developer/git/"
for dir in $(find ~/Developer/git -mindepth 2 -maxdepth 2 -type d); do
	# replace the git path of the directory with the name of the directory
	# e.g. /Users/iolave/Developer/git/iolave -> iolave
    name=$(echo "$dir" | sed "s#$git_path##")
    tmux new-session -d -s "$name" -c "$dir" &> /dev/null
done
exit 0
