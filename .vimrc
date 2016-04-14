set swapfile
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled = 0
set re=1

set dir=~/tmp
set synmaxcol=300
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

nnoremap <Space> <leader>
set shell=bash
set guioptions=agim
" Eevee's vimrc

" set xterm title, and inform vim of screen/tmux's syntax for doing the same
set titlestring=vim\ %{expand(\"%t\")}
if &term =~ "^screen"
    " pretend this is xterm.  it probably is anyway, but if term is left as
    " `screen`, vim doesn't understand ctrl-arrow.
    if &term == "screen-256color"
        set term=xterm-256color
    else
        set term=xterm-256color
    endif

    " gotta set these *last*, since `set term` resets everything
    set t_ts=k
    set t_fs=\
endif
set title

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" backups and other junky files
set nobackup                    " backups are annoying
set writebackup                 " temp backup during write
" TODO: backupdir?
set undodir=~/vimfiles/undo         " persistent undo storage
set undofile                    " persistent undo on

" user interface
set history=1000                " remember command mode history
set laststatus=2                " always show status line
set lazyredraw                  " don't update screen inside macros, etc
set matchtime=2                 " ms to show the matching paren for showmatch
set number                      " line numbers
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set showmatch                   " show matching brackets while typing
set relativenumber              " line numbers spread out from 0
set cursorline                  " highlight current line
set display=lastline,uhex       " show last line even if too long; use <xx>

" regexes
set incsearch                   " do incremental searching
set ignorecase                  " useful more often than not
set smartcase                   " case-sens when capital letters

" whitespace
set autoindent                  " keep indenting on <CR>
set shiftwidth=4                " one tab = four spaces (autoindent)
set softtabstop=4               " one tab = four spaces (tab key)
set tabstop=4                   " hard tabs, too
set expandtab                   " never use hard tabs
set shiftround                  " only indent to multiples of shiftwidth
set smarttab                    " DTRT when shiftwidth/softtabstop diverge
set fileformats=unix,dos        " unix linebreaks in new files please
                                " appearance of invisible characters

" wrapping
"set colorcolumn=+1              " highlight 81st column
set linebreak                   " break on what looks like boundaries
set showbreak=↳\                " shown at the start of a wrapped line
"set textwidth=80                " wrap after 80 columns


" gui stuff
set mouse=a                     " terminal mouse when possible
set guifont=Monaco
                                " nice fixedwidth font

" unicode
set encoding=utf-8              " best default encoding
set listchars=tab:↹·,extends:⇉,precedes:⇇,nbsp:␠,trail:␠,nbsp:␣
setglobal fileencoding=utf-8    " ...
set nobomb                      " do not write utf-8 BOM!
set fileencodings=ucs-bom,utf-8,iso-8859-1
                                " order to detect Unicodeyness

" tab completion
set wildmenu                    " show a menu of completions like zsh
set wildmode=full               " complete longest common prefix first
set wildignore+=.*.sw*,__pycache__,*.pyc
                                " ignore junk files
set complete-=i                 " don't try to tab-complete #included files
set completeopt-=preview        " preview window is super annoying

" miscellany
set autoread                    " reload changed files
set scrolloff=2                 " always have 2 lines of context on the screen
set foldmethod=indent           " auto-fold based on indentation.  (py-friendly)
set foldlevel=99
set timeoutlen=1000             " wait 1s for mappings to finish
set ttimeoutlen=100             " wait 0.1s for xterm keycodes to finish
set nrformats-=octal            " don't try to auto-increment 'octal'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim'
Plug 'vim-scripts/Align'
Plug 'tpope/vim-characterize'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'sjl/gundo.vim'
Plug 'junegunn/gv.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'godlygeek/tabular'
Plug 'vim-airline/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug '~/.fzf'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'vim-scripts/SyntaxRange'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
Plug 'freeo/vim-kalisi'
Plug 'andrwb/vim-lapis256'
Plug 'wellle/targets.vim'
Plug 'sclarki/neonwave.vim'
Plug 'eduardoHoefel/matrix.vim'

call plug#end()


" Syntastic
" Don't bother flaking on :wq because I won't even see it!
let g:syntastic_check_on_wq = 0
" Only use flake8 for Python -- running `python` itself may or may not work
" because versions, and pylint is a beast
let g:syntastic_python_checkers = ['flake8']
" Stupid Unicode tricks
let g:syntastic_error_symbol = "☠"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = "☢"
let g:syntastic_style_warning_symbol = "☹"

" Jedi
" this doesn't fly with the yelp codebase
let g:jedi#popup_on_dot = 0
" messing with my completeopt is super rude
let g:jedi#auto_vim_configuration = 0
" signatures are kind of annoying and unusably slow in a big codebase
let g:jedi#show_call_signatures = 0

" Python-mode; disable linting, use syntastic
let g:pymode_lint = 0
" Aaand the rope stuff conflicts with jedi, surprise
let g:pymode_rope = 0
" Rope is fucking idiotic and keeps recursively reading my entire home
" directory.  This at least tells it not to search upwards looking for a
" .ropeproject marker.
let g:pymode_rope_lookup_project = 0
" This is pretty fucking annoying too
let g:pymode_rope_complete_on_dot = 0

" Airline; use powerline-style glyphs and colors
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

" Ctrl-P settings
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](build|[.]git)$' }
" Try to tame it a bit on very large projects
let g:ctrlp_max_files = 50000
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_dotfiles = 1
let g:ctrlp_lazy_update = 100


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bindings

" Stuff that clobbers default bindings
" Force ^U and ^W in insert mode to start a new undo group
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Leader
let mapleader = " "
let g:mapleader = " "

" Swaps selection with buffer
vnoremap <C-X> <Esc>`.``gvP``P

" ctrl-arrow in normal mode to switch windows; overrides ctrl-left/right for
" moving by words, but i tend to use those only in insert mode
noremap <C-Left> <C-W><Left>
noremap <C-Right> <C-W><Right>
noremap <C-Up> <C-W><Up>
noremap <C-Down> <C-W><Down>

" Bind gb to toggle between the last two tabs
map gb :exe "tabn ".g:ltv<CR>
function! Setlasttabpagevisited()
    let g:ltv = tabpagenr()
endfunction

augroup localtl
    autocmd!
    autocmd TabLeave * call Setlasttabpagevisited()
augroup END
autocmd VimEnter * let g:ltv = 1

" Abbreviation to make `:e %%/...` edit in same directory
cabbr <expr> %% expand('%:.:h')

""" For plugins
" gundo
noremap <Leader>u :GundoToggle<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous autocmds

" Automatically delete swapfiles older than the actual file.
" Look at this travesty.  vim already has this information but doesn't expose
" it, so I have to reparse the swap file.  Ugh.
function! s:SwapDecide()
python << endpython
import os
import struct

import vim

# Format borrowed from:
# https://github.com/nyarly/Vimrc/blob/master/swapfile_parse.rb
SWAPFILE_HEADER = "=BB10sLLLL40s40s898scc"
size = struct.calcsize(SWAPFILE_HEADER)
with open(vim.eval('v:swapname'), 'rb') as f:
    buf = f.read(size)
(
    id0, id1, vim_version, pagesize, writetime,
    inode, pid, uid, host, filename, flags, dirty
) = struct.unpack(SWAPFILE_HEADER, buf)

try:
    # Test whether the pid still exists.  Could get fancy and check its name
    # or owning uid but :effort:
    os.kill(pid, 0)
except OSError:
    # NUL means clean, \x55 (U) means dirty.  Yeah I don't know either.
    if dirty == b'\x00':
        # Appears to be from a crash, so just nuke it
        vim.command('let v:swapchoice = "d"')

endpython
endfunction

if has("python")
    augroup eevee_swapfile
        autocmd!
        autocmd SwapExists * call s:SwapDecide()
    augroup END
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and syntax
" in GUI or color console, enable coloring and search highlighting
if &t_Co > 2 || has("gui_running")
  set background=dark
  set hlsearch
endif

colorscheme lapis256

if has("autocmd")
  " Filetypes and indenting settings
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd BufRead,BufNewFile,BufReadPost,BufWrite,BufWritePost *.etlua set filetype=html
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost,BufNewFile,BufRead,BufWrite,BufWritePost *.etlua call SyntaxRange#Include('<%', '%>', 'lua', 'NonText')

  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif " has("autocmd")

" trailing whitespace and column; must define AFTER colorscheme, setf, etc!
hi ColorColumn ctermbg=black guibg=darkgray
hi WhitespaceEOL ctermbg=red guibg=red
hi Normal ctermbg=none
match WhitespaceEOL /\s\+\%#\@<!$/

" molokai's diff coloring is terrible
highlight DiffAdd    ctermbg=22
highlight DiffDelete ctermbg=52
highlight DiffChange ctermbg=17
highlight DiffText   ctermbg=53
hi LineNr ctermbg=8 cterm=NONE
hi CursorLineNr ctermfg=7 ctermbg=8
hi CursorLine ctermbg=8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Last but not least, allow for local overrides
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif


nmap <F8> :TagbarToggle<CR>
if has("mac") || has("macunix")
    set guifont=Monaco\ for\ Powerline:h24
elseif has("win32") || has("win64")
    set guifont=Monaco\ for\ Powerline:h12:cANSI
    set renderoptions=type:directx,renmode:5
endif

cnoremap cc rsync://root@crescentcode.net/dev/valkyrie_server/
nnoremap <Leader>w :wa<CR>
nnoremap <Leader>q :qa<CR>
nnoremap <Leader>e :xa<CR>
nnoremap <Leader>n :noh<CR>
nnoremap <Leader>v :w<CR>:so %<CR>
