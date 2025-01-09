.PHONY: all

all: setup tmux_setup

setup: stow_install tmux_setup

stow_install:
	bash scripts/install_stow.sh

tmux_setup:
	bash scripts/tmux_setup.sh
