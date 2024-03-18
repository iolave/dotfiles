#!/bin/zsh
# Sets current script root dir
SCRIPT_FILE=$(readlink -f "$0")
ROOT_DIR=$(dirname "$SCRIPT_FILE")

source $ROOT_DIR/dependencies.sh
