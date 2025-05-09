.PHONY: all

all: setup stow_packages

setup: stow_install tmux_setup zsh_setup kiex_setup tools_setup

stow_install:
	bash scripts/install_stow.sh

tmux_setup:
	bash scripts/tmux_setup.sh

zsh_setup:
	bash scripts/zsh_setup.sh

kiex_setup:
	bash scripts/kiex_setup.sh

tools_setup:
	bash scripts/tools_setup.sh

stow_packages:
	stow --target=$(HOME) --restow tmux
	stow --target=$(HOME) --restow zsh
	stow --target=$(HOME) --restow ghostty
	stow --target=$(HOME) --restow nvim
	stow --target=$(HOME) --restow vim
	stow --target=$(HOME) --restow git
