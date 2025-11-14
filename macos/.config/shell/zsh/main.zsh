#!/bin/zsh

# Sets current script root dir
SCRIPT_FILE=$(readlink -f "$0")
ROOT_DIR=$(dirname "$SCRIPT_FILE")

export LC_ALL=C.UTF-8
export LANG=C.UTF-8
export LC_CTYPE=C.UTF-8

source $ROOT_DIR/oh-my-zsh.pre.zsh
source $ROOT_DIR/oh-my-zsh.zsh
source $ROOT_DIR/apps.zsh
source $ROOT_DIR/brew.zsh
source $ROOT_DIR/environment.zsh
source $ROOT_DIR/aliases.zsh
source $ROOT_DIR/functions.zsh

if [ -f $ROOT_DIR/custom.zsh ]; then
  source $ROOT_DIR/custom.zsh
fi

