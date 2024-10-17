#!/bin/zsh

# Docker env
export DOCKER_HOST=ssh://iolave@10.0.20.20

# Bun env
export BUN_INSTALL="$HOME/.bun"
PATH="$BUN_INSTALL/bin:$PATH"
export PATH="${PATH}:${HOME}/go/bin"
if [[ "$(uname)" == "Darwin" ]]; then
        [ -s "/Users/$(whoami)/.bun/_bun" ] && source "/Users/$(whoami)/.bun/_bun"
fi

# Volta env
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export EDITOR=vim
