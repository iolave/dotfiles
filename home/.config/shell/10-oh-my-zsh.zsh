#!/bin/zsh

# ########################
# Oh My Zsh installation #
# ########################
if [ ! -d ~/.oh-my-zsh ]; then
  echo "info: installing oh-my-zsh"
  KEEP_ZSHRC=yes eval "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions 
fi

THEMES_DIR="${HOME}/.oh-my-zsh/custom/themes"
MY_THEMES_DIR="${HOME}/.config/shell/themes"
if [ ! -h "$THEMES_DIR" ]; then
	rm -rf $THEMES_DIR
	ln -s $MY_THEMES_DIR $THEMES_DIR
fi


# ########################
# Oh My Zsh config       #
# ########################
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="centos-like"

plugins=(
	git
	zsh-autosuggestions
	brew
	macos
	colored-man-pages
)

source $ZSH/oh-my-zsh.sh
