" ----- PLUGINS {{{

call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'rakr/vim-two-firewatch'
Plug 'Nequo/vim-allomancer'
Plug 'nanotech/jellybeans.vim'
Plug 'rose-pine/vim'
Plug 'drsooch/gruber-darker-vim'

call plug#end()

" }}}

" Change leader
let mapleader = " "

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" copy to clipboard
set clipboard=unnamedplus

syntax on

set relativenumber
set number
set nocul

set wildmenu

set background=dark " or light if you prefer the light version



if !has('gui_running') && &term =~ '\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors

colorscheme GruberDarker

autocmd Filetype markdown set wrap
autocmd Filetype markdown set linebreak

nmap <leader>e :Explore<CR>
