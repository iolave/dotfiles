SYSTEM_NAME=$(uname)
if [[ "${SYSTEM_NAME}" == "Darwin" ]]; then
	source "${HOME}/.config/shell/zsh/main.zsh"
	return
fi

