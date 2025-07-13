#!/bin/bash


cd tmux/.tmux/plugins/

function get_or_update {
	echo "Getting tmux plugin @ $1"

	FOLDER=`basename ${1%.*}`

	if [ ! -d $FOLDER ]; then
		git clone $1
	else
		cd $FOLDER
		git pull
		cd ..
	fi
}
get_or_update git@github.com:tmux-plugins/tpm.git
get_or_update git@github.com:Morantron/tmux-fingers.git
get_or_update git@github.com:tmux-plugins/tmux-sensible.git

echo "tmux dependencies installed"
