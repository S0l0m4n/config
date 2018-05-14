" VIMRC
" vi-improved mode
set nocompatible

" cycle buffers without writing
"set hidden

" backup while writing
"set writebackup

" file completion
set wildmenu
set wildmode=list:longest

" update window title
set title

" display cursor location
set ruler

" line numbers on
set number

" display current command and mode
set showcmd
set showmode

" short message prompts
"set shortmess=atI

" silent
set noerrorbells

" switch to current file's directory
"set autochdir

" remember marks, registers, searches, buffer list
"set viminfo='20,<50,s10,h,%

" keep a big history
"set history=1000

" syntax highlighting
syntax on

" auto smart code indent
set autoindent
filetype indent on
set smartindent
set smarttab
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set shiftround

" max chars on each line
" To format lines according to this text width, highlight with V and press gq.
" You can format from the current position to the end of the paragraph with gq}.
set textwidth=80
autocmd FileType gitcommit set textwidth=72
"autocmd FileType gitcommit set colorcolumn+=51

" allow backspacing in insert mode
set backspace=indent,eol,start

" incremental search
set incsearch

" search highlighting
set hlsearch
" use <CR> to temporarily disable
:nnoremap <CR> :nohlsearch<CR><CR>

" ignore case
set ignorecase
set smartcase

" restore last cursor position
function! RESTORE_CURSOR()
	if line("'\"") > 0 && line ("'\"") <= line("$")
		exe "normal! g'\""
	endif
endfunction
autocmd BufReadPost * call RESTORE_CURSOR()

" navigate code using exuberant ctags
"set tags=tags;$HOME
"set tags+=$HOME/.vim/tags/cpp
"set tags+=$HOME/.vim/tags/curl
"set tags+=$HOME/.vim/tags/httpd
"set tags+=$HOME/.vim/tags/libmozjs
"set tags+=$HOME/.vim/tags/libxml2

set mouse=a

set pastetoggle=<F2>

" toggle line numbers on/off for copy-paste with mouse
nnoremap <F5> :set number! nonumber?<CR>

nnoremap <F7> :setlocal spell! nospell?<CR>

autocmd bufreadpre *.html,*.css setlocal ts=2 sts=2 sw=2
