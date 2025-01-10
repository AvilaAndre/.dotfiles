.PHONY: all

all: setup tmux_setup stow_packages

setup: stow_install tmux_setup zsh_setup

stow_install:
	bash scripts/install_stow.sh

tmux_setup:
	bash scripts/tmux_setup.sh

zsh_setup:
	bash scripts/zsh_setup.sh

stow_packages:
	stow --target=$(HOME) tmux
	stow --target=$(HOME) zsh
	stow --target=$(HOME) ghostty
	stow --target=$(HOME) nvim
	stow --target=$(HOME) vim
