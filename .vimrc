syntax on

" show the current line number, and relative line numbers
set number relativenumber 

set tabstop=4
set softtabstop=4
set shiftwidth=4
set hlsearch "highlight search results
set expandtab "turn tabs into spaces
set autoindent

set cursorline "show current line with cursor

hi Search cterm=NONE ctermfg=black ctermbg=yellow

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR>

"F2 and F3 to move to next/previous buffer
map <F2> :bprev<CR>
map <F3> :bnext<CR>

"Colors
"https://github.com/catppuccin/vim
set termguicolors
colorscheme catppuccin_mocha

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes

" vim-fzf
" https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()
