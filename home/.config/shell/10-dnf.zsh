#!/bin/zsh
# check if apt is installed
which dnf &> /dev/null
if [ $? -ne 0 ]; then
	return 
fi

echo "TODO: implement dnf package installation"
