#!/bin
# Sets current script root dir
SCRIPT_FILE=$(readlink -f "$0")
ROOT_DIR=$(dirname "$SCRIPT_FILE")

function prompt_yn() {
	MSG=$1

	if [[ "${MSG}" == "" ]]; then
        	echo "Do you want to continue [Y/n]?"
	else		
        	echo "${MSG}. Do you want to continue [Y/n]?"
	fi

        old_stty_cfg=$(stty -g)
        stty raw -echo
        answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
        stty $old_stty_cfg

        if [[ "$answer" != "${answer#[Yy]}" ]];then
                return 0
        else
                return 1
        fi
}

UNINSTALLED_DEPENDENCIES=()
function brew_dependency_check () {
	DEP=$1
	PKG=$2

	if [[ "${DEP}" == "" ]]; then
		echo "[ERROR] brew_dependency_check() called without a dependency name at ${SCRIPT_FILE}"
		unset -f brew_dependency_check 
		return 1
	fi

	if [[ "${PKG}" != "" ]]; then
		which ${DEP} &> /dev/null
		IS_INSTALLED=$?

		if [[ "$IS_INSTALLED" != "0" ]]; then
			UNINSTALLED_DEPENDENCIES+=("${PKG}")
		fi

		return
	fi

	which ${DEP} &> /dev/null
	IS_INSTALLED=$?

	if [[ "$IS_INSTALLED" != "0" ]]; then
		UNINSTALLED_DEPENDENCIES+=("${DEP}")
	fi
}

function install_dependencies() {
	DEPS=$@

	if [[ "${DEPS}" == "" ]]; then
		return
	fi

	prompt_yn "Dependencies '${DEPS}' are not installed"
        PROMPT_VALUE=$?
        if [[ "$PROMPT_VALUE" == "1" ]]; then
            	echo "[WARN] dependencies '${DEPS}' were not installed"
		return
	fi

	IFS=" "
	eval "brew install ${DEPS[*]}"

}

which brew &> /dev/null
IS_BREW_INSTALLED=$?
if [[ "$IS_BREW_INSTALLED" != "0" ]]; then
	prompt_yn "homebrew is not installed"
        PROMPT_VALUE=$?
	if [[ "$PROMPT_VALUE" == "1" ]]; then
            	echo "[WARN] homebrew was not installed"
		return
	fi
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	which brew &> /dev/null
	IS_BREW_INSTALLED=$?
fi

SYSTEM_NAME=$(uname)
if [[ "$IS_BREW_INSTALLED" == "0" ]]; then
	if [[ "${SYSTEM_NAME}" == "Darwin" ]]; then
		brew_dependency_check jq
		brew_dependency_check tmux
		brew_dependency_check curl
		brew_dependency_check docker
		brew_dependency_check aws awscli
		brew_dependency_check htop
		brew_dependency_check nvim neovim
		brew_dependency_check nmap 
		brew_dependency_check openvpn
		brew_dependency_check telnet
		brew_dependency_check stow
		brew_dependency_check volta
		brew_dependency_check go golang
		brew_dependency_check mongosh
		brew_dependency_check rustc rust
		# brew_dependency_check visual-studio-code
		# brew_dependency_check tiles
		# brew_dependency_check alt-tab

		install_dependencies $UNINSTALLED_DEPENDENCIES
	fi
fi

unset -f brew_dependency_check 
unset -f install_dependencies
unset -f prompt_yn
