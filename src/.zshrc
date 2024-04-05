SYSTEM_NAME=$(uname)
if [[ "${SYSTEM_NAME}" == "Darwin" ]]; then
	source "/Users/$(whoami)/.config/shell/zsh/main.sh"
	return
fi

