if [ ! -d $HOME/.config/shell ]; then
	echo "warn: shell config dir not found"
else
	for f in $HOME/.config/shell/*.zsh; do
		source $f
	done
fi
