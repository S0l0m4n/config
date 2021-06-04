" VIMRC
" Example vimrc file based on one I found on the Internet (I couldn't find it
" when I tried to search now). Stuff I didn't need or understand, I commented
" out. I've made some additions of my own.
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
"set smartindent
set smarttab
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set shiftround

set autoread

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
nnoremap <F4> :set nohlsearch! hlsearch?<CR>

" ignore case
set ignorecase
nnoremap <F6> :set noic! ic?<CR>
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

map @@x !%xmllint --format --recover -<CR>

autocmd bufreadpre *.html,*.css setlocal ts=2 sts=2 sw=2
autocmd bufreadpre *.py,*.sh setlocal ts=4 sts=4 sw=4

" Set tab size to only two spaces for C source and header files
" Ditto for YAML files
autocmd BufRead,BufNewFile *.c,*.cpp,*.h,*.yml setlocal ts=2 sts=2 sw=2 et

function! LoadCscope()
	let db = findfile("cscope.out", ".;")
	if (!empty(db))
		let path = strpart(db, 0, match(db, "/cscope.out$"))
		set nocscopeverbose " suppress 'duplicate connection' error
		exe "cs add " . db . " " . path
		set cscopeverbose
		" else add the database pointed to by environment variable
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
endfunction

if has("cscope")
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    au BufEnter /* call LoadCscope()

    " show msg when any other cscope db added
    set cscopeverbose

	""""""""""""" Cscope settings from Jason Duell
	""""""""""""" <http://cscope.sourceforge.net/cscope_maps.vim>
	" The following maps all invoke one of the following cscope search types:
	"
	"   's'   symbol: find all references to the token under cursor
	"   'g'   global: find global definition(s) of the token under cursor
	"   'c'   calls:  find all calls to the function name under cursor
	"   't'   text:   find all instances of the text under cursor
	"   'e'   egrep:  egrep search for the word under cursor
	"   'f'   file:   open the filename under cursor
	"   'i'   includes: find files that include the filename under cursor
	"   'd'   called: find functions that function under cursor calls
	"
	" Below are three sets of the maps: one set that just jumps to your
	" search result, one that splits the existing vim window horizontally and
	" diplays your search result in the new window, and one that does the same
	" thing, but does a vertical split instead (vim 6 only).
	"
	" I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
	" unlikely that you need their default mappings (CTRL-\'s default use is
	" as part of CTRL-\ CTRL-N typemap, which basically just does the same
	" thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
	" If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
	" of these maps to use other keys.  One likely candidate is 'CTRL-_'
	" (which also maps to CTRL-/, which is easier to type).  By default it is
	" used to switch between Hebrew and English keyboard mode.
	"
	" All of the maps involving the <cfile> macro use '^<cfile>$': this is so
	" that searches over '#include <time.h>" return only references to
	" 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
	" files that contain 'time.h' as part of their name).


	" To do the first type of search, hit 'CTRL-\', followed by one of the
	" cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
	" search will be displayed in the current window.  You can use CTRL-T to
	" go back to where you were before the search.
	"

	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>


	" Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
	" makes the vim window split horizontally, with search result displayed in
	" the new window.
	"
	" (Note: earlier versions of vim may not have the :scs command, but it
	" can be simulated roughly via:
	"    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

	nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>


	" Hitting CTRL-space *twice* before the search type does a vertical
	" split instead of a horizontal one (vim 6 and up only)
	"
	" (Note: you may wish to put a 'set splitright' in your .vimrc
	" if you prefer the new window on the right instead of the left

	nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
endif
