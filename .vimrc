"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Plug auto installer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimPlug Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
    Plug 'airblade/vim-gitgutter'
    Plug 'aldantas/vim-custom-surround'
    Plug 'chrisbra/Colorizer'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'flrnprz/candid.vim'
    Plug 'dyng/ctrlsf.vim'
    Plug 'edkolev/tmuxline.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'jlanzarotta/bufexplorer'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'roxma/vim-tmux-clipboard'
    Plug 'sheerun/vim-polyglot'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'simeji/winresizer'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'tmhedberg/matchit'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-vinegar'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Yggdroot/indentLine'
    Plug 'w0rp/ale'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set noshowmode
set noswapfile
set encoding=utf-8
filetype plugin on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set magic

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch
set ignorecase
set incsearch
set showmatch
set smartcase


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bells
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set novisualbell
set noerrorbells


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guioptions-=e
if !has('gui_running')
    set termguicolors
    set t_Co=256
endif
colorscheme candid
" let g:dracula_italic = 0
highlight Normal ctermbg=None


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" True Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &term =~# '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leaders
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=";"
let g:mapleader=";"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BufExplorer Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>
map <leader>ba :bufdo bd<cr>
map <leader>bd :Bclose<cr>:tabclose<cr>gT


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <c-j> <C-W>j
noremap <c-k> <C-W>k
noremap <c-h> <C-W>h
noremap <c-l> <C-W>l
noremap <C-=> <C-W>=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bash keys for command line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePre * :%s/\s\+$//e


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" xmllint
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>x :%!xmllint --format % <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" json prettyprinter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>jj :%!python -m json.tool <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlSF settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <Leader>s <Plug>CtrlSFVwordPath <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hide search highlights, location list, quickfix list
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <silent> <leader><esc> :noh <bar> lcl <bar> ccl<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Switch CWD to path of open buffer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>cd :cd %:p:h<cr>:pwd<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Split Lines
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap K i<CR><Esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove Recording
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map q <Nop>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tmuxline Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tmuxline_status_justify = 'centre'
" let g:tmuxline_theme = 'airline'
" let g:tmuxline_preset = 'crosshair'
" let g:tmuxline_preset = {
"             \'a'    : '#S',
"             \'c'    : '#(whoami)',
"             \'win'  : ['#I', '#W'],
"             \'cwin'  : ['#I', '#W'],
"             \'x'    : '#(date)',
"             \'y'    : ['%r', '%a', '%Y'],
"             \'z'    : '#H',
" }
" let g:tmuxline_separators = {
"             \ 'left' : '',
"             \ 'left_alt': '⮀',
"             \ 'right' : '',
"             \ 'right_alt' : '⮂',
"             \ 'space' : ' '}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline Settings (statusline)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='dracula'
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#tmuxline#status_justify = "centre"
" let airline#extensions#tmuxline#color_template = 'visual'
" let airline#extensions#tmuxline#snapshot_file = "/home/jorenza/.tmuxline.conf"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autopairs Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:AutoPairsShortcutToggle = '<Leader>m'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle number and relative number
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set relativenumber
noremap <leader>n :call ToggleNumber()<cr>
function! ToggleNumber()
    IndentLinesToggle
	GitGutterToggle
    set number!
    set relativenumber!
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=indent
set foldlevel=1
nnoremap <space> za


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copying Pasting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>v :setlocal paste!<cr>"
set clipboard+=unnamedplus


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Saving
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! W w !sudo tee % > /dev/null
nnoremap <leader>w :w!<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RipGrep settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('rg')
	set grepprg=rg\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf settings
" ;a will search for the word under the cursor
" ;g will search for words
" ;f will search for files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <Leader>a :Rg <C-R><C-W><CR>
nmap <Leader>g :Rg <cr>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ 'rg
  \ --column
  \ --glob "*.{py,html}"
  \ --glob "/home/jorenza/git/cms/src/**"
  \ --glob "!{.git,node_modules,.min.js}/*"
  \ --hidden
  \ --ignore-case
  \ --line-number
  \ --no-heading
  \ --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

nmap <Leader>f :Find <cr>
command! -bang -nargs=* Find
  \ call fzf#vim#grep(
  \	'rg
  \ --colors=line:none
  \ --colors=line:style:bold
  \ --files
  \ --fixed-strings
  \ --follow
  \ --hidden
  \ --ignore-case
  \ --line-number
  \ --max-columns=150
  \ --no-ignore
  \ --no-heading
  \ --smart-case
  \ --glob "!{.git,node_modules,vendor}/*"
  \ --glob "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ --glob "/home/jorenza/git/cms/src/*"
  \ --color "always"'.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Brian Shenanigans (gf, paths)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap gf :BrianOpenFile<cr>
nmap <Leader>p :call BrianPathList()<cr>

command! BrianOpenFile call BrianOpenFile()
function! BrianOpenFile()
try
	let g:BrianOpenFileName = matchstr(expand("<cfile>"), ".*")
	execute ':find ' . g:BrianOpenFileName
catch /.*/
	try
		let g:BrianOpenFileName = expand("<cfile>") . ".js"
		execute ':find ' . g:BrianOpenFileName
	catch /.*/
		try
			let g:BrianOpenFileName = tr(expand("<cfile>"), ".", "/") . ".py"
			execute ':find ' . g:BrianOpenFileName
		catch /.*/
			try
				let g:BrianOpenFileName = matchstr(expand("<cfile>"), "[^/].*")
				execute ':find ' . g:BrianOpenFileName
			catch /.*/
			endtry
		endtry
	endtry
endtry
"echo g:BrianOpenFileName
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Path settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=/home/jorenza/git/cms/src/247/apps247
set path+=/home/jorenza/git/cms/src/247/templates_backend
set path+=/home/jorenza/git/cms/src/247/staticfiles


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Vinegar settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_list_hide='.*\.pyc$'
augroup netrw_keychange
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END
function! NetrwMapping()
    setl bufhidden=wipe
    noremap <buffer>q :bd<CR>
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorizer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>c :ColorHighlight<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ale settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#ale#enabled = 1

" Linters
let g:ale_linters = {
    \'javascript': ['prettier', 'eslint'],
    \'python': ['flake8', 'autopep8', 'isort']
\}
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" Fixers
let g:ale_fixers = {
    \'javascript': ['prettier', 'eslint'],
    \'python': ['flake8', 'autopep8', 'isort']
\}
let g:ale_fix_on_save = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Surround setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let lf = '<C-v><CR>'
let vimCommentStart = repeat('"', 70) . lf . '"\ '
let vimCommentEnd = lf . repeat('"', 70)
let bashCommentStart = repeat('#', 70) . lf . '#\ '
let bashCommentEnd = lf . repeat('#', 70)
let ppStart = lf . 'from\ pprint\ import\ pprint' . lf . 'pprint('
let ppEnd = ')' . lf
let pdb =  'import\ pdb;\ pdb.set_trace()' . lf
let pdbEnd = ppEnd . pdb

call customsurround#map('<Leader>pp', ppStart, ppEnd)
call customsurround#map('<Leader>pdb', ppStart, pdbEnd)
call customsurround#map('<Leader>vc', vimCommentStart, vimCommentEnd)
call customsurround#map('<Leader>bc', bashCommentStart, bashCommentEnd)
call customsurround#map('<Leader>cl', 'console.log({\ ', '\ });')
call customsurround#map('<Leader>ch', '\%V')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python Syntax Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self
