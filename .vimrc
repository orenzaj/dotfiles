"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Plug autoinstaller """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim augroup auto_src_vimrc
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    augroup END
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
    Plug 'dracula/vim', { 'as': 'dracula'}
    Plug 'dyng/ctrlsf.vim'
    Plug 'flrnd/candid.vim'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'itchyny/lightline.vim'
    Plug 'jesseleite/vim-agriculture'
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'mattn/emmet-vim'
    Plug 'maximbaz/lightline-ale'
    Plug 'roxma/vim-tmux-clipboard'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'sheerun/vim-polyglot'
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
    Plug 'Yggdroot/indentLine'
    Plug 'ryanoasis/vim-devicons'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nohidden
set nocompatible
set noswapfile
set encoding=utf-8
scriptencoding utf-8
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
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent

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
    let &t_8f = '\<Esc>[38;2;%lu;%lu;%lum'
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leaders
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=';'
let g:mapleader=';'


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
autocmd QuitPre * if empty(&bt) | lclose | endif


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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline Settings (statusline)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
            \ 'colorscheme': 'dracula',
            \ 'active':  {
            \   'left': [ [ 'mode, paste' ],
            \             [ 'gitbranch', 'readonly', 'filename' ] ],
            \   'right': [ ['lineinfo'],
            \              ['percent'],
            \              ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok'] ]
            \ },
            \ 'component_function':  {
            \   'gitbranch': 'fugitive#head',
            \   'filename': 'LightlineFilename'
            \ },
            \ 'component_expand':  {
            \   'linter_checking': 'lightline#ale#checking',
            \   'linter_warnings': 'lightline#ale#warnings',
            \   'linter_errors': 'lightline#ale#errors',
            \   'linter_ok': 'lightline#ale#ok',
            \ },
            \ 'component_type':  {
            \   'linter_checking': 'left',
            \   'linter_warnings': 'warning',
            \   'linter_errors': 'error',
            \   'linter_ok': 'left',
            \ }
            \}

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:lightline#ale#indicator_checking = "⧖"
let g:lightline#ale#indicator_warnings = "◆ "
let g:lightline#ale#indicator_errors = "✗ "
let g:lightline#ale#indicator_ok = "✓ "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dev Icons settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:webdevicons_enable = 1
let g:webdevicons_enable_vimfiler = 1
let g:webdevicons_enable_unite = 1
let g:DevIconsEnableFoldersOpenClose = 1 " Enable open and close folder glyph flags.
let g:WebDevIconsUnicodeDecorateFolderNodes = 1 " Enable folder glyph flag.
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = '' " Disable folder icons.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Django Testing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>t :exe "!tmux send -t 1 'execfile(\"test/%\")' Enter"<CR><C-L>
nnoremap <silent> <leader>T :exe "!tmux send -t 1 'execfile(\"test/utils.py\")' Enter"<CR><C-L>

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
set foldlevel=3
set foldlevelstart=99
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
    set grepprg='rg\
                \ --vimgrep\
                \ --color=always\
                \ --glob "!{.git,node_modules}/*"\
                \ --glob "!*.[style.css\|.md\|.log\|min.js]"'
    set grepformat=%f:%l:%c:%m
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rooter settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rooter_resolve_links = 1
let g:rooter_change_directory_for_non_project_files = ''
let g:rooter_use_lcd = 1
let g:rooter_manual_only = 1
let g:rooter_patterns = ['Rakefile', '.git', '.git/']
map <leader>cr :Rooter <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf settings
" ;a will search for the content in the project folder
" ;s will search for words
" ;f will search for files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \ 'rg
            \ --column
            \ --glob "*.{py,html}"
            \ --glob "!{.git,node_modules}/*"
            \ --glob "!*[style.css\|.md\|.log\|{min,compiled}.js]"
            \ --hidden
            \ --files
            \ --smart-case
            \ --line-number
            \ --no-heading
            \ --color=always '.shellescape(expand("<cword>")), 1,
            \ fzf#vim#with_preview(),
            \ <bang>0)
            \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
            \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
            \   <bang>0)

command! -bang Buffers
            \ call fzf#vim#buffers({'up': '30%', 'options': '--reverse --margin 3%,15%'}, <bang>0)

" Files + devicons
function! Fzf_files_with_dev_icons()
    let l:fzf_files_options = '--ansi --preview "bat --color always --style numbers {2..} | head -'.&lines.'"'
    function! s:edit_devicon_prepended_file(item)
        let l:file_path = a:item[4:-1]
        execute 'silent e' l:file_path
    endfunction
    call fzf#run({
                \ 'source': 'rg --column --hidden --files --line-number --no-heading --color=always | devicon-lookup',
                \ 'sink': function('s:edit_devicon_prepended_file'),
                \ 'options': '-m ' . l:fzf_files_options,
                \ 'down': '40%' })
endfunction

" ;f will search files with DevIcons
" nmap <Leader>f :call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND)<CR> " :Files
nmap <Leader>f :call Fzf_files_with_dev_icons()<CR> " :Files

" ;s will search for words at root level /
nmap <Leader>s <Plug>RgRawSearch<CR>

" ;a will search for the content in the project folder
vmap <Leader>a <Plug>RgRawVisualSelection<CR>
nmap <Leader>a <Plug>RgRawWordUnderCursor<CR>

" ;o will open the buffers
nmap <Leader>o :Buffers <cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Brian Shenanigans (gf)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap gf :BrianOpenFile<cr>
nmap <Leader>p :call BrianPathList()<cr>

command! BrianOpenFile call BrianOpenFile()
function! BrianOpenFile()
    try
        let g:BrianOpenFileName = matchstr(expand('<cfile>'), '.*')
        execute ':find ' . g:BrianOpenFileName
    catch /.*/
        try
            let g:BrianOpenFileName = expand('<cfile>') . '.js'
            execute ':find ' . g:BrianOpenFileName
        catch /.*/
            try
                let g:BrianOpenFileName = tr(expand('<cfile>'), '.', '/') . '.py'
                execute ':find ' . g:BrianOpenFileName
            catch /.*/
                try
                    let g:BrianOpenFileName = matchstr(expand('<cfile>'), '[^/].*')
                    execute ':find ' . g:BrianOpenFileName
                catch /.*/
                endtry
            endtry
        endtry
    endtry
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Path settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=/home/jorenza/git/centerprise
set path+=/home/jorenza/go/src/github.com/Apartments24-7/centerprise
set path+=/home/jorenza/git/cms/src/247/apps247
set path+=/home/jorenza/git/cms/src/247/templates_backend
set path+=/home/jorenza/git/cms/src/247/staticfiles

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Emmet settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:user_emmet_leader_key='<Leader>'
let g:user_emmet_install_global = 1
augroup emmet_filetypes
    autocmd!
    autocmd FileType html,css EmmetInstall
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Vinegar settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hide hidden files ('gh' to toggle)
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+\'

" Hide .pyc files
let g:netrw_list_hide='.*\.pyc$'

" Fix duplicates showing
let g:netrw_fastbrowse=2

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ale settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_open_list = 1

" Linters
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1

" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'

" Fixers
let g:ale_fixers = {
            \ 'python': ['autopep8', 'reorder-python-imports'],
            \ 'javascript': ['prettier', 'eslint'],
            \ '*': ['remove_trailing_lines', 'trim_whitespace']
            \}
let b:ale_python_flake8_options = '--max-line-length=100 --ignore=E722,E226,W503'
let b:ale_python_autopep8_options = '--max-line-length=100 --ignore=E722,E226,W503'
let g:ale_fix_on_save = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go Syntax Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_highlight_function_parameters = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
let g:go_highlight_variable_assignments = 1
let g:go_doc_keywordprg_enabled = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python Syntax Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let python_highlight_all = 1
augroup python_filetype
    au FileType python syn keyword pythonDecorator True None False self
augroup END
