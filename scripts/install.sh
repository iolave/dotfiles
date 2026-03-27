#!/bin/bash
set -e
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/.."

# create all necessary dirs
rm -rf "$ROOT_DIR/.tmp"
mkdir -p "$ROOT_DIR/.tmp/.config/shell"

# Detect window manager
system=$(uname -s)
if [ "$system" == "Linux" ]; then
	if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]; then
		wm="kde-$KDE_SESSION_VERSION"
	fi
elif [ "$system" == "Darwin" ]; then
	wm="macos"
else
	wm="unknown"
fi

if [ ! -d "$ROOT_DIR/window-manager/$wm" ]; then
	echo "WARN: window manager config not found for $wm"
else
	echo "INFO: detected window manager config for $wm"
	stow -d "$ROOT_DIR/window-manager/$wm/.config" -t .tmp/.config .
fi

# home dotfiles config
stow -d "$ROOT_DIR/home" -t .tmp/ .

stow -d "$ROOT_DIR/.tmp/" -t "$HOME/" .
echo "INFO: installed dotfiles to $HOME"
