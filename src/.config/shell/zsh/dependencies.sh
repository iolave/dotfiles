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

function brew_dependency_check () {
	DEP=$1

	if [[ "${DEP}" == "" ]]; then
		echo "[ERROR] brew_dependency_check() called without a dependency name at ${SCRIPT_FILE}"
		unset -f brew_dependency_check 
		return 1
	fi

	which ${DEP} &> /dev/null
	IS_INSTALLED=$?

	if [[ "$IS_INSTALLED" != "0" ]]; then
		prompt_yn  "'${DEP}' is not installed"
        	PROMPT_VALUE=$?
        	if [[ "$PROMPT_VALUE" == "1" ]]; then
               		echo "[WARN] ${DEP} not installed"
			return
        	fi
		
		brew install ${DEP}
	fi
}

SYSTEM_NAME=$(uname)

if [[ "${SYSTEM_NAME}" == "Darwin" ]]; then
	brew_dependency_check jq
	brew_dependency_check tmux

	unset -f brew_dependency_check 
fi

