"----------------------------------------------------------------------
"                          General settings
"----------------------------------------------------------------------

" Home away from home. We store some config files and snippets here and the
" whole dotfiles dir is a git repo. Should be the last entry in rtp (for
" UltiSnips).
set rtp+=$HOME/dotfiles/vim

" We want our cross-machine spell file to be used
set spellfile=$HOME/dotfiles/vim/spell/en.latin1.add

" DISPLAY SETTINGS
set t_Co=256   " This is may or may not needed.
colorscheme PaperColor
" colorscheme peaksea
" colorscheme valloric    " sets the colorscheme
set background=dark     " enable for dark terminals
set scrolloff=2         " 2 lines above/below cursor when scrolling
set showmatch           " show matching bracket (briefly jump)
set matchtime=2         " reduces matching paren blink time from the 5[00]ms def
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set title               " show file in titlebar
set undofile            " stores undo state even when files are closed (in undodir)
set nocursorline          " highlights the current line
set winaltkeys=no       " turns of the Alt key bindings to the gui menu
set splitright

" When you type the first tab, it will complete as much as possible, the second
" tab hit will provide a list, the third and subsequent tabs will cycle through
" completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu            " completion with menu
" This changes the default display of tab and CR chars in list mode
set listchars=tab:▸\ ,eol:¬

" The "longest" option makes completion insert the longest prefix of all
" the possible matches; see :h completeopt
set completeopt=menu,menuone,longest
set switchbuf=useopen,usetab

" EDITOR SETTINGS
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
" this can cause problems with other filetypes
" see comment on this SO question http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim/234578#234578
set smartindent         " smart auto indenting
set autoindent          " on new lines, match indent of previous line
set copyindent          " copy the previous indentation on autoindenting
set cindent             " smart indenting for c-like code
set cino=b1,g0,N-s,t0,(0,W4  " see :h cinoptions-values
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set nobackup            " no backup~ files.

set tabstop=4           " number of spaces a tab counts for
set shiftwidth=4        " spaces for autoindents
set softtabstop=4
set shiftround          " makes indenting a multiple of shiftwidth
set expandtab           " turn a tab into spaces
set laststatus=2        " the statusline is now always shown
set noshowmode          " don't show the mode ("-- INSERT --") at the bottom

" misc settings
set fileformat=unix     " file mode is unix
set fileformats=unix,dos,mac   " detects unix, dos, mac file formats in that order

set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo
                        " file -- 20 jump links, regs up to 500 lines'

set hidden              " allows making buffers hidden even with unsaved changes
set history=1000        " remember more commands and search history
set undolevels=1000     " use many levels of undo
set autoread            " auto read when a file is changed from the outside
set mouse=a             " enables the mouse in all modes
set foldlevelstart=99   " all folds open by default

" toggles vim's paste mode; when we want to paste something into vim from a
" different application, turning on paste mode prevents the insertion of extra
" whitespace
set pastetoggle=<F7>

" Right-click on selection should bring up a menu
set mousemodel=popup_setpos

" With this, the gui (gvim and macvim) now doesn't have the toolbar, the left
" and right scrollbars and the menu.
set guioptions-=T
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=M

" this makes sure that shell scripts are highlighted
" as bash scripts and not sh scripts
let g:is_posix = 1

" tries to avoid those annoying "hit enter to continue" messages
" if it still doesn't help with certain commands, add a second <cr>
" at the end of the map command
set shortmess=a

" this solves the "unable to open swap file" errors on Win7
set dir=~/.cache/tmp,/var/tmp,/tmp,$TEMP
set undodir=~/.cache/tmp,/var/tmp,/tmp,$TEMP

" Look for tag def in a "tags" file in the dir of the current file, then for
" that same file in every folder above the folder of the current file, until the
" root.
set tags=./.tags;,.tags

" turns off all error bells, visual or otherwise
set noerrorbells visualbell t_vb=
au vimrc GUIEnter * set visualbell t_vb=

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" none of these should be word dividers, so make them not be
set iskeyword+=_,$,@,%,#

" Number of screen lines to use for the command-line
set cmdheight=2

" allow backspace and cursor keys to cross line boundaries
"set whichwrap+=<,>,h,l
set nowrap
set hlsearch          " do not highlight searched-for phrases
set incsearch           " ...but do highlight-as-I-type the search string
set gdefault            " this makes search/replace global by default

" enforces a specified line-length and auto inserts hard line breaks when we
" reach the limit; in Normal mode, you can reformat the current paragraph with
" gqap.
set textwidth=80

" this makes the color after the textwidth column highlighted
set colorcolumn=+1
highlight ColorColumn ctermbg=235

" options for formatting text; see :h formatoptions
set formatoptions=tcroqnj

" This limits the size of the max number of items to show in Vim's popup menu
" (which is used by YouCompleteMe).
set pumheight=10

" Post Vim 7.4, the "new" regexpengine (value 2) is the default and is slower
" than the "old" enginer (value 1), which means syntax highlighting is slow.
" Benchmarked on Vim 8.1.1576 with https://gist.github.com/glts/5646749 and the
" new engine is now faster in almost all benchmarks! So we use value 0, which
" usually picks the new engine unless it detects it would be slower, and then it
" falls back to the old engine.
set regexpengine=0

" The alt (option) key on macs now behaves like the 'meta' key. This means we
" can now use <m-x> or similar as maps. This is buffer local, and it can easily
" be turned off when necessary (for instance, when we want to input special
" characters) with :set nomacmeta.
if has("gui_macvim")
  set macmeta
endif

if has('unnamedplus')
  " By default, Vim will not use the system clipboard when yanking/pasting to
  " the default register. This option makes Vim use the system default
  " clipboard.
  " Note that on X11, there are _two_ system clipboards: the "standard" one, and
  " the selection/mouse-middle-click one. Vim sees the standard one as register
  " '+' (and this option makes Vim use it by default) and the selection one as
  " '*'.
  " See :h 'clipboard' for details.
  set clipboard=unnamedplus,unnamed
else
  " Vim now also uses the selection system clipboard for default yank/paste.
  set clipboard+=unnamed
endif

" Auto saving! Having used Intellij IDEA, autosave is the only way to go
set autowriteall
au FocusLost * silent! wa

" Makes neovim GUI's implement 'autoread' like gvim does. See:
"   https://github.com/neovim/neovim/issues/1936
"au FocusGained * :checktime

" When opening a file, go to the last position we were on
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

au vimrc BufEnter *.snippets setf snippets
au vimrc BufEnter *.tpl setf html
au vimrc BufEnter *.acl setf yaml
au vimrc BufEnter *.gradle setf groovy
au vimrc BufEnter *.pdsc setf json
au vimrc BufEnter *.conf setf conf

" In UltiSnips snippet files, we want actual tabs instead of spaces for indents.
" US will use those tabs and convert them to spaces if expandtab is set when the
" user wants to insert the snippet.
au vimrc FileType snippets set noexpandtab

" The stupid python filetype plugin overrides our settings!
au vimrc FileType python
      \ set tabstop=4 |
      \ set shiftwidth=4 |
      \ set softtabstop=4

au vimrc FileType cpp
      \ set tabstop=2 |
      \ set shiftwidth=2 |
      \ set softtabstop=2

au vimrc FileType c
      \ set tabstop=8 |
      \ set shiftwidth=8 |
      \ set softtabstop=8 |
      \ set noexpandtab

