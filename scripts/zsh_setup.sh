#!/bin/bash

cd zsh/.config/zsh/plugins

function get_or_update {
	echo "Getting zsh plugin @ $1"

	FOLDER=`basename ${1%.*}`

	if [ ! -d $FOLDER ]; then
		git clone $1
	else
		cd $FOLDER
		git pull
		cd ..
	fi
}

get_or_update git@github.com:romkatv/zsh-defer.git
get_or_update git@github.com:zsh-users/zsh-autosuggestions.git
get_or_update git@github.com:zsh-users/zsh-syntax-highlighting.git

echo "zsh plugins installed"
