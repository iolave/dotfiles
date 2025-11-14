# warp config
if [ ! -d "$HOME/.warp/themes" ]; then
	mkdir -p $HOME/.warp
	git clone --depth 1 https://github.com/warpdotdev/themes.git $HOME/.warp/themes
fi

