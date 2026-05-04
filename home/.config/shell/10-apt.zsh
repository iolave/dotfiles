#!/bin/zsh

# check if apt is installed
which apt &> /dev/null
if [ $? -ne 0 ]; then
	return 
fi

function check_install_with_known_binary() {
	bin=$1
	pkg=$2

	if [ "$pkg" = "" ]; then
		pkg=$bin
	fi

	if [ "$bin" = "" ]; then
		echo "error: no bin provided"
		return 1
	fi

	which $bin &> /dev/null
	if [ $? -eq 0 ]; then
		return 0
	fi

	echo "info: installing $pkg"
	sudo apt install $pkg
}

# PACKAGES WITH KNOWN BINARIES
check_install_with_known_binary "go" "golang"
check_install_with_known_binary "fzf"
check_install_with_known_binary "nvim" "neovim"
check_install_with_known_binary "uuidgen" "uuid-runtime"
check_install_with_known_binary "htop"
check_install_with_known_binary "rgrep" "ripgrep"
check_install_with_known_binary "ksystemlog"
check_install_with_known_binary "tree-sitter" "tree-sitter-cli"
check_install_with_known_binary "obs" "obs-studio"
check_install_with_known_binary "aws" "awscli"
check_install_with_known_binary "sshuttle"

# TEMURIN JDK
if [ ! -f "/etc/apt/sources.list.d/adoptium.list" ]; then
sudo su -c '
	# CHANGE THIS TO THE ACTUAL SUPPORTED CODENAME
	# https://packages.adoptium.net/ui/native/deb/dists/
	CODENAME="trixie" 

	# ADD KEY AND REPO
	wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
	echo "deb https://packages.adoptium.net/artifactory/deb ${CODENAME} main" | tee /etc/apt/sources.list.d/adoptium.list

	# INSTALL
	apt update
	apt install -y temurin-25-jdk
'
fi

# SLACK
if [ ! -f "/etc/apt/sources.list.d/slack.sources" ]; then
	curl -fsSL https://packagecloud.io/slacktechnologies/slack/gpgkey | gpg --dearmor | sudo tee /etc/apt/keyrings/slacktechnologies_slack-archive-keyring.gpg > /dev/null
	sudo tee /etc/apt/sources.list.d/slack.sources > /dev/null <<'EOF'
Types: deb
URIs: https://packagecloud.io/slacktechnologies/slack/debian/
Suites: jessie
Components: main
Architectures: amd64
Signed-By: /etc/apt/keyrings/slacktechnologies_slack-archive-keyring.gpg
EOF
	sudo apt update
	sudo apt install slack-desktop
fi

if [ ! -d "/opt/postman" ]; then
	echo "info: installing postman"
	tar -C /tmp/ -xzf <(curl -L https://dl.pstmn.io/download/latest/linux64) \
		&& sudo mv /tmp/Postman /opt/postman
	sudo tee -a /usr/share/applications/postman.desktop << END
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/postman/Postman
Icon=/opt/postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
END
fi

# DOCKER
which docker &> /dev/null
if [ $? -eq 1 ]; then
	sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
	sudo apt update
	sudo apt install docker-ce docker-ce-cli containerd.io
fi

