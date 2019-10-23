"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Plug auto installer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimPlug Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
    Plug 'airblade/vim-rooter'
    Plug 'airblade/vim-gitgutter'
    Plug 'aldantas/vim-custom-surround'
    Plug 'chrisbra/Colorizer'
    Plug 'dense-analysis/ale'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'dyng/ctrlsf.vim'
    Plug 'edkolev/tmuxline.vim'
    Plug 'flrnd/candid.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'mattn/emmet-vim'
    Plug 'roxma/vim-tmux-clipboard'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'sheerun/vim-polyglot'
    Plug 'Shougo/deoplete.nvim'
    Plug 'Shougo/unite.vim'
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
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set nohidden
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
" xmllint pretty printer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>xpp :%!xmllint --format % <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" json prettyprinter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>jpp :%!python -m json.tool <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run python file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>r :!python %:p <CR>


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
let g:tmuxline_separators = {
            \ 'left' : '',
            \ 'left_alt': '⮀',
            \ 'right' : '',
            \ 'right_alt' : '⮂',
            \ 'space' : ' '}


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
" Django Testing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>t :exe "!tmux send -t 1 'execfile(\"test/%\")' Enter"<CR><C-L>

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rooter settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rooter_change_directory_for_non_project_files = 'current'
" let g:rooter_use_lcd = 1
" let g:rooter_manual_only = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf settings
" ;a will search for the content in the project folder
" ;s will search for words
" ;f will search for files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ 'rg
  \ --column
  \ --glob "*.{py,html}"
  \ --glob "!{.git,node_modules,.min.js}/*"
  \ --hidden
  \ --smart-case
  \ --line-number
  \ --no-heading
  \ --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..', 'dir': FindRootDirectory()}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..', 'dir': FindRootDirectory()}, 'right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang Buffers
  \ call fzf#vim#buffers({'up': '30%', 'options': '--reverse --margin 3%,15%'}, <bang>0)


command! ProjectFiles execute 'Files' FindRootDirectory()
command! ColorTheme call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })<CR>
nmap <Leader>a :Rg <C-R><C-W><CR>
nmap <Leader>b :Buffers <cr>
nmap <Leader>c :ColorTheme <cr>
nmap <Leader>f :ProjectFiles<cr>
nmap <Leader>s :Rg <cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Brian Shenanigans (gf, paths)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap gf :BrianOpenFile<cr>
nmap <Leader>p :call BrianPathList()<cr>

command! BrianOpenFile call BrianOpenFile()
function! BrianOpenFile()
try
	let g:BrianOpenFileName = matchstr(expand("<cfile>"), ".*")
    echo "1"
    echo g:BrianOpenFileName
	execute ':find ' . g:BrianOpenFileName
catch /.*/
	try
		let g:BrianOpenFileName = expand("<cfile>") . ".js"
        echo "2"
        echo g:BrianOpenFileName
		execute ':find ' . g:BrianOpenFileName
	catch /.*/
		try
			let g:BrianOpenFileName = tr(expand("<cfile>"), ".", "/") . ".py"
            echo "3"
            echo g:BrianOpenFileName
			execute ':find ' . g:BrianOpenFileName
		catch /.*/
			try
				let g:BrianOpenFileName = matchstr(expand("<cfile>"), "[^/].*")
                echo "4"
                echo g:BrianOpenFileName
				" execute ':find ' . g:BrianOpenFileName
			catch /.*/
			endtry
		endtry
	endtry
endtry
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Path settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=/home/jorenza/git/cms/src/247/apps247
set path+=/home/jorenza/git/cms/src/247/templates_backend
set path+=/home/jorenza/git/cms/src/247/staticfiles

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Emmet settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:user_emmet_leader_key='<Leader>'
let g:user_emmet_install_global = 1
autocmd FileType html,css EmmetInstall

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Vinegar settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_list_hide='.*\.pyc$'
augroup netrw_keychange
    autocmd!
    autocmd filetype defx call NetrwMapping()
augroup END
function! NetrwMapping()
    setl bufhidden=wipe
    noremap <buffer>q :bd<CR>
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorizer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>h :ColorHighlight<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deoplete settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {'_': ['ale', ]})

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ale settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#ale#enabled = 1
let g:ale_open_list = 1

" Linters
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1

" Fixers
let g:ale_fixers = {
            \'python': ['add_blank_lines_for_python_control_statements',
                        \'autopep8', 'black', 'isort',
                        \'reorder-python-imports', 'yapf'],
            \'javascript': ['prettier', 'eslint'],
            \'*': ['remove_trailing_lines', 'trim_whitespace']
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
