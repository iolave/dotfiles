PATH_DEV="$HOME/Developer"
export DEV=$PATH_DEV

# Allows to open vscode faster
function code() {
        PATH_CODE="/Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron"
	eval "($PATH_CODE ${@:1} &> /dev/null &)"
}

# Allows me to use a linux like ip -a command
function ip() {
	if [ "$1" = "a" ]; then
		IFCONFIG_FLAGS="-a ${@:2}"
	else
		IFCONFIG_FLAGS="${@:1}"
	fi
	
	eval "ifconfig $IFCONFIG_FLAGS"
}

function dev() {
        if [ -d "$PATH_DEV" ]; then
                cd $PATH_DEV
                return 0
        else
                echo "Directory '$PATH_DEV' not found"
                return 1
        fi
}

PATH_ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
export ICLOUD=$PATH_ICLOUD

function icloud() {
        if [ -d "$PATH_ICLOUD" ]; then
                cd $PATH_ICLOUD
                return 0
        else
                echo "Directory '$PATH_ICLOUD' not found"
                return 1
        fi
}

# git update branch
function gub () {
	git pull origin $(git branch --show-current)
}

