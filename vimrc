" UNIX CONFIGURATIONS
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" TABS
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noswapfile
set number
set relativenumber

" PLUGS
call plug#begin("~/.vim/plugged")

Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

call plug#end()

" SHORTCUTS
let mapleader = ";"
let g:mapleader = ";"
map <leader>n :NERDTreeToggle<CR>
nmap <leader>w :w!<cr>

" WINDOWS
map J <C-W>j
map K <C-W>k
map H <C-W>h
map L <C-W>l
