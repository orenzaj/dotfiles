" This will auto install vim-plug if empty(glob('~/.vim/autoload/plug.vim'))
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

" Save vim info
set viminfo+=! " make sure it can save viminfo

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif|call RecentFilesAdd()

" VimPlug Settings
call plug#begin('~/.vim/plugged')
    Plug 'airblade/vim-gitgutter'
    Plug 'dyng/ctrlsf.vim'
    Plug 'ggreer/the_silver_searcher'
    Plug 'jiangmiao/auto-pairs'
    Plug 'jlanzarotta/bufexplorer'
    Plug 'mileszs/ack.vim'
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'roxma/vim-tmux-clipboard'
    Plug 'sheerun/vim-polyglot'
    Plug 'simeji/winresizer'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'vim-airline/vim-airline'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-vinegar'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-scripts/RecentFiles'
    Plug 'w0rp/ale'
    Plug 'edkolev/tmuxline.vim'
call plug#end()

set termguicolors
if !has('gui_running')
    set t_Co=256
endif
colorscheme dracula

if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" TABS
syntax on
set expandtab
set guioptions-=e
set hlsearch
set ignorecase
set incsearch
set magic
set nocompatible
set noerrorbells
set noshowmode
set noswapfile
set novisualbell
set number
set relativenumber
set shiftwidth=4
set showmatch
set smartcase
set softtabstop=4
set tabstop=4

" Leaders
let mapleader=";"
let g:mapleader=";"

" Fast save
nnoremap <leader>w :w!<cr>

" Set foldmethod
nnoremap <leader>z :set foldmethod=indent<cr>

" Vim Copy settings
set clipboard=unnamed,unnamedplus
vmap <leader>yy "+y
nmap <leader>pp "+p
map <leader>p :setlocal paste!<cr>

" :W sudo saves
command! W w !sudo tee % > /dev/null

" Search with space
noremap <space> /
noremap <c-space> ?

" Ack settings
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif
cnoreabbrev Ack Ack!
map <leader>a :Ack<CR>
vnoremap <Leader>a y:Ack <C-r>=fnameescape(@")<CR><CR>")
vnoremap <Leader>f y:AckFile! <C-r>=fnameescape(@")<CR><CR>")

" CtrlSF settings
vmap <Leader>s <Plug>CtrlSFVwordPath <CR>

" Disable search highlights, location list, quickfix list
noremap <silent> <leader><esc> :noh <bar> lcl <bar> ccl<cr>

" Switch CWD to path of open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Recent Files
nmap <leader>f :call RecentFilesList()<cr>

" Split Lines
nnoremap K i<CR><Esc>

" Airline Settings (statusline)
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='dracula'

" Autopairs Settings
let g:AutoPairsShortcutToggle = '<Leader>m'

" Vim Vinegar settings
augroup netrw_keychange
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END
function! NetrwMapping()
    setl bufhidden=wipe
    noremap <buffer><leader>nn :bd<CR>
    noremap <buffer>q :bd<CR>
endfunction

" BufExplorer Settings
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>
map <leader>ba :bufdo bd<cr>
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Window Navigation
noremap <c-j> <C-W>j
noremap <c-k> <C-W>k
noremap <c-h> <C-W>h
noremap <c-l> <C-W>l
noremap <C-=> <C-W>=

" Bash keys for command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

" Delete trailing white space
autocmd BufWritePre * :%s/\s\+$//e

" Ale settings
let g:ale_fixers = {
    \'javascript': ['prettier', 'eslint'],
    \'python': ['isort', 'autopep8'],
\}
let g:ale_fix_on_save = 1

" Python Syntax Settings
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self
