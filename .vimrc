" This will auto install vim-plug if empty(glob('~/.vim/autoload/plug.vim'))
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

" Save vim info
set viminfo+=! " make sure it can save viminfo

" This beauty remembers where you were the last time you edited the file, and
" returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif|call RecentFilesAdd()

" VimPlug Settings
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'jlanzarotta/bufexplorer'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-obsession'   
    Plug 'airblade/vim-gitgutter'
    Plug 'vim-syntastic/syntastic'
    Plug 'mileszs/ack.vim'
    Plug 'ggreer/the_silver_searcher'
    Plug 'vim-scripts/RecentFiles'
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'itchyny/lightline.vim'
call plug#end()

set termguicolors
set background=dark

if !has('gui_running')
    set t_Co=256
endif 
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

colorscheme PaperColor
syntax on
set mouse=a

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

" Disable search highlights, location list, quickfix list
noremap <silent> <leader><esc> :noh <bar> lcl <bar> ccl<cr>

" Switch CWD to path of open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Recent Files
nmap <leader>f :call RecentFilesList()<cr>


" Light Line (statusline)
set laststatus=2 
let g:lightline = {
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


" set statusline=%{HasPaste()}%F%m%r%h\ %w\ \ \ \ \ \ 
" set statusline+=column:\ %c
" set statusline+=%{ObsessionStatus('[active]','[paused]')}

" Syntastic Settings
let g:syntastic_python_checkers=['flake8']
" let g:syntastic_python_flake8_post_args='--ignore=E256,E702,E266,E722,E731,E501,E225,F841,F401,F403,F405' 
let g:syntastic_python_flake8_post_args='--ignore=E722' 
let g:syntastic_python_pep8_args='--ignore=E722' 
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

nnoremap <silent> <F5> :SyntasticCheck<CR>  

" NERDTree Settings
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

" Bash keys for command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

" Delete trailing white space 
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has ("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces() 
endif

" Python Syntax Settings 
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self
au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako
au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f #--- <esc>a
map <buffer> F :set foldmethod=indent<cr>
map <buffer> M :set foldmethod=manual<cr>
au FileType python map <buffer> <leader>1 /class 
au FileType python map <buffer> <leader>2 /def 
au FileType python map <buffer> <leader>C ?class 
au FileType python map <buffer> <leader>D ?def 
au FileType python set cindent
au FileType python set cinkeys-=0#
au FileType python set indentkeys-=0#
