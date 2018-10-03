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
    Plug 'ggreer/the_silver_searcher'
    Plug 'mileszs/ack.vim'
    Plug 'jlanzarotta/bufexplorer'
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'vim-scripts/RecentFiles'
    Plug 'itchyny/lightline.vim'
    Plug 'natebosch/vim-lsc'
    Plug 'inkarkat/vim-mark'
    Plug 'inkarkat/vim-ingo-library'
    Plug 'python-rope/ropevim'
    Plug 'dyng/ctrlsf.vim'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'roxma/vim-tmux-clipboard'
    Plug 'will133/vim-dirdiff'
    Plug 'vim-scripts/TeTrIs.vim'
    Plug 'tpope/vim-vinegar'
    Plug 'mattn/emmet-vim/'
    Plug 'jiangmiao/auto-pairs'
    Plug 'simeji/winresizer'
    Plug 'w0rp/ale'
call plug#end()

set termguicolors
if !has('gui_running')
    set t_Co=256
endif
set background=dark
colorscheme PaperColor

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"


" TABS
set guioptions-=e
set noshowmode
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noswapfile
set number
set relativenumber
set incsearch
set hlsearch
set ignorecase
set smartcase
set showmatch
set magic
set noerrorbells
set novisualbell

" Leaders
let mapleader=";"
let g:mapleader=";"

" Fast save
nnoremap <leader>w :w!<cr>

" Vim Copy settings
set clipboard=unnamed,unnamedplus
vmap <leader>yy "+y
nmap <leader>pp "+p

" Toggle paste mode on and off
map <leader><leader>p :setlocal paste!<cr>

" :W sudo saves
command! W w !sudo tee % > /dev/null

" Search with space
noremap <space> /
noremap <c-space> ?

" Ack settings
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif

" Ack settings
cnoreabbrev Ack Ack!
map <leader>a :Ack<CR>
vnoremap <Leader>a y:Ack <C-r>=fnameescape(@")<CR><CR>")
vnoremap <Leader>f y:AckFile! <C-r>=fnameescape(@")<CR><CR>")

" Disable search highlights, location list, quickfix list
noremap <silent> <leader><esc> :noh <bar> lcl <bar> ccl<cr>

" Switch CWD to path of open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Recent Files
nmap <leader>f :call RecentFilesList()<cr>

" Split Lines
nnoremap K i<CR><Esc>

" Light Line (statusline)
set laststatus=2

let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }
let g:lightline = {
            \ 'colorscheme': 'PaperColor',
            \ 'component_function': {
            \   'filename': 'LightLineFilename'
            \ },
            \ 'active': {
            \   'left': [ [ 'mode', 'paste',  ], [ 'readonly', 'relativepath', 'modified' ] ],
            \ }
            \ }
function! LightLineFilename()
    return expand('%:F')
endfunction


" Autopairs Settings
let g:AutoPairsShortcutToggle = '<Leader>m'

" NERDTree Settings
let NERDTreeHijackNetrw=1
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=35
let NERDTreeShowHidden=0
let NERDTreeIgnore=['\.pyc$', '__pycache__']
noremap <leader>nn :NERDTreeToggle<CR>

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
    \'javascript': ['eslint'],
    \'python': ['flake8'],
\}

" Python Syntax Settings
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self
au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako
map <buffer> F :set foldmethod=indent<cr>
au FileType python set cindent
au FileType python set cinkeys-=0#
au FileType python set indentkeys-=0#
