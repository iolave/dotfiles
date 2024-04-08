# Checking for oh-my-zsh install. If it is not found it will ran
# the install command from the website (https://ohmyz.sh/)
if [ "$(uname)" = "Darwin" ]; then
	if [ ! -f "/Users/$(whoami)/.oh-my-zsh/oh-my-zsh.sh" ]; then
		KEEP_ZSHRC=yes eval "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 
	fi
fi
