"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Last modification: Sat Dec 14 22:09:59 DST 2019
"
" Guided by vim-bootstrap: https://github.com/avelino/vim-bootstrap
" Change your ~/.vimrc as follows:
"   set runtimepath+=<path to this repository>
"   source <path to this repository>/vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                preamble                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let work_path = $HOME . '/work/work_vim_settings.vim'
let at_work = filereadable( work_path )


function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc

call Terminal_MetaMode(0)


" Setup vim-plug
call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Vundle configuration                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" These need to come before the configuration options for the plugins since
" vundle will add the plugin folders to the runtimepath only after it has seen
" the plugin's Plugin command.

Plug 'vim-scripts/FSwitch', {'for': ['c', 'cpp']}
"Plug 'JesseKPhillips/d.vim'
Plug 'vim-scripts/L9'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'Raimondi/delimitMate'
"Plug 'vim-scripts/Rename'
Plug 'SirVer/ultisnips'
" Plug 'Valloric/ListToggle'
Plug 'Valloric/MatchTagAlways', { 'for': 'html' }
"Plug 'Valloric/Vim-Jinja2-Syntax'
Plug 'Valloric/vim-operator-highlight'
Plug 'Valloric/vim-valloric-colorscheme'
"Plug 'Valloric/xmledit'
"Plug 'vim-scripts/YankRing.vim'
" Seems more active than tpope/vim-surround
Plug 'anyakichi/vim-surround'
" Plug 'bufkill.vim'
"Plug 'cespare/vim-toml'
"Plug 'dart-lang/dart-vim-plugin'
Plug 'godlygeek/tabular'
" For markdown preview; call :Preview to open rendered in browser
" Plug 'greyblake/vim-preview'
"Plug 'groenewege/vim-less'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
"Plug 'justinmk/vim-sneak'
Plug 'honza/vim-snippets'
" Yet another markdown preview plugin
" After install, needs: mkdp#util#install()
"Plug 'majutsushi/tagbar'
Plug 'vim-scripts/matchit.zip'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mileszs/ack.vim'
Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp' }
"Plug 'othree/eregex.vim'
"Plug 'tpope/vim-markdown', {'for': 'markdown'}
"Plug 'iamcco/markdown-preview.nvim', {'for': 'markdown'}
Plug 'othree/html5.vim', {'for': 'html'}
Plug 'mattn/emmet-vim', {'for': ['html', 'php']}
Plug 'skammer/vim-css-color', {'for': 'css'}
Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'Valloric/python-indent', {'for': 'python'}
Plug 'vim-scripts/python.vim', {'for': 'python'}
Plug 'vim-scripts/python_match.vim', {'for': 'python'}
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'rust-lang/rust.vim'
" No async support? Using ALE now.
Plug 'dense-analysis/ale', {'for': ['c', 'cpp', 'python']}
"Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
" Problems with fugitive, re-evalute when upstream fixes the issue
" Plug 'sjl/splice.vim'
" Requires extra binaries; see docs
" Plug 'suan/vim-instant-markdown'
" For higlighting the word under the cursor
"Plug 't9md/vim-quickhl'
Plug 'tomtom/tcomment_vim'
" Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'mbbill/undotree'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-vinegar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/asyncrun.vim', {'for': ['c', 'cpp']}
Plug 'tpope/vim-unimpaired'

if !at_work
  Plug 'Shougo/echodoc.vim', {'for': ['c', 'cpp']}
  Plug 'ycm-core/YouCompleteMe', {'for': ['c', 'cpp']}
endif

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           pre-filetype tweaks                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" these are for the xmledit plugin
let xml_use_xhtml = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           reset vimrc augroup                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" We reset the vimrc augroup. Autocommands are added to this group throughout
" the file
augroup vimrc
  au!
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        turn on filetype plugins                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable detection, plugins and indenting in one step
" This needs to come AFTER the Plugin commands!
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            General settings                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Home away from home. We store some config files and snippets here and the
" whole dotfiles dir is a git repo. Should be the last entry in rtp (for
" UltiSnips).
set rtp+=$HOME/dotfiles/vim

" We want our cross-machine spell file to be used
set spellfile=$HOME/dotfiles/vim/spell/en.latin1.add

" TODO: transfer all our custom mapping to our vim_shortcuts file

" DISPLAY SETTINGS
set t_Co=256   " This is may or may not needed.
colorscheme PaperColor
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
set cursorline          " highlights the current line
set winaltkeys=no       " turns of the Alt key bindings to the gui menu

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
"set dir=~/tmp,/var/tmp,/tmp,$TEMP
"set undodir=~/tmp,/var/tmp,/tmp,$TEMP

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
set nohlsearch          " do not highlight searched-for phrases
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

" The stupid rust filetype plugin overrides our settings!
"au vimrc FileType rust
"      \ set tabstop=2 |
"      \ set shiftwidth=2 |
"      \ set softtabstop=2 |
"      \ set textwidth=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           More involved tweaks                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Unicode support (taken from http://vim.wikia.com/wiki/Working_with_Unicode)
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

" Source: https://vi.stackexchange.com/a/456
fun! s:TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

" Automatically delete trailing DOS-returns and whitespace on file open and
" write.
au vimrc BufRead,BufWritePre,FileWritePre * silent! call s:TrimWhitespace()

" this maximizes the gvim window on startup
if has("gui_win32")
  " this maximizes on windows
  au vimrc GUIEnter * simalt ~x
else
  " We never maximize in macvim. We rely on it remembering the window size
  " itself.
  if !has("gui_macvim")
    " NOTE: Needs 'sudo apt install wmctrl' to work!
    au vimrc GUIEnter * call system(
          \ 'wmctrl -i -b add,maximized_vert,maximized_horz -r ' . v:windowid )
  endif
endif

" Sets a font for the GUI
if has("gui_gtk2") || has("gui_gtk3")
  set guifont=Consolas\ For\ Powerline\ 10
" For neovim-gtk
elseif exists('g:GtkGuiLoaded')
  call rpcnotify(1, 'Gui', 'Font', 'Consolas For Powerline 12')
elseif has("gui_macvim")
  set guifont=Consolas\ For\ Powerline:h14
elseif has("gui_win32")
  set guifont=Consolas\ For\ Powerline:h14
end

" For neovim-gtk
if exists('g:GtkGuiLoaded')
  " Disable the ugly custom completion menu
  call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
endif

" Sometimes, $MYVIMRC does not get set even though the vimrc is sourced
" properly. So far, I've only seen this on Linux machines on rare occasions.
if has("unix") && strlen($MYVIMRC) < 1
  let $MYVIMRC=$HOME . '/.vimrc'
endif

" Highlight Class and Function names
fun! s:HighlightFunctionsAndClasses()
  syn match cCustomFunc      "\w\+\s*\((\)\@="
  syn match cCustomClass     "\w\+\s*\(::\)\@="

  hi def link cCustomFunc      Function
  hi def link cCustomClass     Function
endfunction

" Highlight Class and Function names, D specific
fun! s:HighlightDFunctionsAndClasses()
  syn match cCustomDFunc     "\w\+\s*\(!.\{-}(\)\@="
  syn match cCustomDFuncUFCS ".\w\+\s*\(!.\{-}\)\@="

  hi def link cCustomDFunc     Function
  hi def link cCustomDFuncUFCS Function
endfunction

" TODO: this should:
" a) not be called for every filetype
" b) be in a separate plugin
au vimrc Syntax * call s:HighlightFunctionsAndClasses()
au vimrc Syntax d call s:HighlightDFunctionsAndClasses()


" TODO: split this into separate plugin
fun! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        execute "Ack " . l:pattern . ' %'
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
vnoremap <silent> gv :call VisualSearch('gv')<CR>

" cindent is a bit too smart for its own good and triggers in text files when
" you're typing inside parens and then hit enter; it aligns the text with the
" opening paren and we do NOT want this in text files!
au vimrc FileType text,markdown,gitcommit,hgcommit set nocindent

au vimrc FileType markdown setlocal spell! spelllang=en_us

" Open epub files as if they were zip files (because they are)
au vimrc BufReadCmd *.epub call zip#Browse( expand( "<amatch>" ) )

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            custom mappings                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NOTE: a lot of these mappings won't make sense until you realize I'm using a
" "Dvorak-Qwerty Command" layout (and similar on Win/Lin). The layout is Dvorak
" unless you hold down Ctrl or Alt or Cmd; then it changes to Qwerty. This type
" of layout gives us Dvorak typing but Qwerty keyboard shortcuts.

" our <leader> will be the space key
let mapleader=" "

" our <localleader> will be the '-' key
let maplocalleader="-"

" this makes vim's regex engine "not stupid"
" see :h magic
nnoremap / /\v
vnoremap / /\v

" With this map, we can select some text in visual mode and by invoking the map,
" have the selection automatically filled in as the search text and the cursor
" placed in the position for typing the replacement text. Also, this will ask
" for confirmation before it replaces any instance of the search text in the
" file.
" NOTE: We're using %S here instead of %s; the capital S version comes from the
" eregex.vim plugin and uses Perl-style regular expressions.
" NOTE: `/cm` means: c for confirm match, m for multiline regex. For details,
" see :h eregex-option
vnoremap <C-r> "hy:%S/<C-r>h//cm<left><left><left>

" Fast saving
nnoremap <leader>w :w!<cr>

" <leader>v brings up .vimrc
" <leader>V reloads it and makes all changes active (file has to be saved first)
noremap <leader>v :e! $MYVIMRC<CR>
noremap <silent> <leader>V :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" with this, we can now type ",." to exit out of insert mode
" if we really wanted to type ",.", then just type one char, wait half a sec,
" type another
inoremap ,. <Esc>
vnoremap ,. <Esc>

" CTRL-U and CTRL-W in insert mode cannot be undone.  Use CTRL-G u to first
" break undo, so that we can undo those changes after inserting a line break.
" For more info, see: http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" This command will allow us to save a file we don't have permission to save
" *after* we have already opened it. Super useful.
cnoremap w!! w !sudo tee % >/dev/null

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Now we don't have to move our fingers so far when we want to scroll through
" the command history; also, don't forget the q: command (see :h q: for more
" info)
cnoremap <c-j> <down>
cnoremap <c-k> <up>

" Keep search matches in the middle of the window.
" zz centers the screen on the cursor, zv unfolds any fold if the cursor
" suddenly appears inside a fold.
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

" Also center the screen when jumping through the changelist
nnoremap g; g;zz
nnoremap g, g,zz

" In normal mode, we use : much more often than ; so lets swap them.
" WARNING: this will cause any "ordinary" map command without the "nore" prefix
" that uses ":" to fail. For instance, "map <f2> :w" would fail, since vim will
" read ":w" as ";w" because of the below remappings. Use "noremap"s in such
" situations and you'll be fine.
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" This makes j and k work on "screen lines" instead of on "file lines"; now, when
" we have a long line that wraps to multiple screen lines, j and k behave as we
" expect them to.
nnoremap j gj
nnoremap k gk

" Use Q for formatting the current paragraph (or visual selection)
vnoremap Q gq
nnoremap Q gqap

" This is quit all
noremap <leader>q :qa<cr>

" key bindings for quickly moving between windows
" h left, l right, k up, j down
noremap <Tab>h <c-w>h
noremap <Tab>l <c-w>l
noremap <Tab>k <c-w>k
noremap <Tab>j <c-w>j

" for faster scrolling
" TODO: create a command for scrolling by ~70% of the window height
noremap <c-j> 15gj
noremap <c-k> 15gk

" Switches to the previous buffer that was shown in the current window, but also
" closes the current buffer before switching to the previous one
" noremap <leader>bq <c-^> :bd #<cr>

" Switch to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>

" Toggle and untoggle spell checking
noremap <leader>ss :setlocal spell! spelllang=en_us<cr>

" spelling shortcuts using <leader>
" ]s next misspelled word
" [s previous misspelled word
" zg add to dict
" z= get suggestions
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>sa zg
noremap <leader>su z=

" Using '<' and '>' in visual mode to shift code by a tab-width left/right by
" default exits visual mode. With this mapping we remain in visual mode after
" such an operation.
vnoremap < <gv
vnoremap > >gv

noremap <leader>b <c-o>
noremap <leader>f <c-i>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       ***  HERE BE PLUGINS  ***                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               LeaderF                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
noremap <c-n> :LeaderfMru<cr>
noremap <m-p> :LeaderfFunction!<cr>
noremap <m-n> :LeaderfBuffer<cr>
noremap <m-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

" Trying out LeaderF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                fzf.vim                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This hides the dumb "N/M" propt which shows num match/num total entries
" let $FZF_DEFAULT_OPTS .= '--color pointer:0,bg+:-1,info:0,prompt:0 --inline-info'
" " This hides the current folder prefix to file search
" let g:fzf_files_options = ['--prompt', '> ']
""
"nnoremap <leader>t :Files<cr>
"nnoremap <leader>n :History<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 undotree                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" f5 toggles the Gundo plugin window
nnoremap <F4> :UndotreeToggle<CR>
let g:undotree_width=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              gutentags                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

let g:gutentags_ctags_tagfile = '.tags'

let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                asyncrun                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:asyncrun_open = 6
let g:asyncrun_bell = 1
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
nnoremap <silent> <F8> :AsyncRun -cwd=<root> make <cr>
nnoremap <silent> <F5> :AsyncRun g++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <silent> <F11> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                yankring                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:yankring_history_dir = '$HOME/tmp/vim'
"" this is so that single char deletes don't end up in the yankring
"let g:yankring_min_element_length = 2
"let g:yankring_window_height = 14
"nnoremap <leader>r :YRShow<CR>
"
"" this makes Y yank from the cursor to the end of the line, which makes more
"" sense than the default of yanking the whole current line (we can use yy for
"" that)
"fun! YRRunAfterMaps()
"  nnoremap Y :<C-U>YRYankCount 'y$'<CR>
"endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                session                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" you also need to run :SaveSession once to create the default.vim session that
" will then be autoloaded/saved from then on

"let g:session_autoload        = 'no'
"let g:session_autosave        = 'yes'
"let g:session_default_to_last = 'yes'
"let g:session_directory       = '~/tmp/vim/sessions'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                tabular                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" looks at the current line and the lines above and below it and aligns all the
" equals signs; useful for when we have several lines of declarations
nnoremap <leader>a= :Tabularize /=<CR>
vnoremap <leader>a= :Tabularize /=<CR>
nnoremap <leader>a/ :Tabularize /\/\//l2c1l0<CR>
vnoremap <leader>a/ :Tabularize /\/\//l2c1l0<CR>
nnoremap <leader>a, :Tabularize /,/l0r1<CR>
vnoremap <leader>a, :Tabularize /,/l0r1<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                UltiSnips                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" we can't use <tab> as our snippet key since we use that with YouCompleteMe
let g:UltiSnipsSnippetsDir         = $HOME . '/dotfiles/vim/UltiSnips'
let g:UltiSnipsExpandTrigger       = "<m-s>"
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsListSnippets        = "<c-m-s>"
let g:UltiSnipsJumpForwardTrigger  = "<right>"
let g:UltiSnipsJumpBackwardTrigger = "<left>"
let g:snips_author                 = 'Strahinja Val Markovic'

" NOTE: To get a snippet to expand in-word (for instance, within parens), add
" the letter "i" after the snippet header. Ex: snippet ss "std::string" i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              vim-preview                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This forces vim-preview to use the default browser on linux; it already uses
" 'open' on Mac.
"if has("unix")
"  let g:PreviewBrowsers = "xdg-open"
"endif
"
"let g:PreviewMarkdownFences = 1

" Use :Preview command to open in browser!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                ack.vim                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
elseif executable('ag')
  let g:ackprg = "ag --nocolor --nogroup --column"
elseif executable('ack-grep')
  let g:ackprg = "ack-grep --nocolor --nogroup --column"
elseif executable('ack')
  let g:ackprg = "ack --nocolor --nogroup --column"
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                bufkill                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use the arrows for something useful
" :BB switches to the previous buffer shown in the current window, :BF switches
" to the next one; it's like a buffer history for every window
" noremap <right> :BF<cr>
" noremap <left> :BB<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                fswitch                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" A "companion" file is a .cpp file to an .h file and vice versa

" Opens the companion file in the current window
" Can be used to switch between header and source file, for example.
nnoremap <leader>sh :FSHere<cr>

" Opens the companion file in the window to the left (window needs to exist)
" This is actually a duplicate of the :FSLeft command which for some reason
" doesn't work.
nnoremap <leader>sl :call FSwitch('%', 'wincmd l')<cr>

" Same as above, only opens it in window to the right
nnoremap <leader>sr :call FSwitch('%', 'wincmd r')<cr>

" Creates a new window on the left and opens the companion file in it
nnoremap <leader>sv :FSSplitLeft<cr>

" This handles c++ files with the ".cc" extension.
augroup workccfiles
  au!
  au BufEnter *.cc let b:fswitchdst  = 'h,hxx'
  au BufEnter *.cc let b:fswitchlocs = './,reg:/src/include/,reg:|src|include/**|,../include'

  if !at_work
    au BufEnter *.h  let b:fswitchdst  = 'cpp,cc,c'
  else
    au BufEnter *.h  let b:fswitchdst  = 'cc,cpp,c'
  endif
  au BufEnter *.h  let b:fswitchlocs = './,reg:/include/src/,reg:/include.*/src/,../src'
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                vim-git                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn on spell checking by default for git commit messages
au vimrc FileType gitcommit setlocal spell! spelllang=en_us


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                tagbar                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:tagbar_left = 1
"let g:tagbar_sort = 0
"let g:tagbar_width = 60
"let g:tagbar_ctags_bin = '/usr/local/bin/ctags'

" *OpenAutoClose is meant to be used for the usecase of 'open Tagbar, move
" cursor there, move to entry, press enter, close window'. Differs from the
" *Toggle version by moving the cursor to the window and closing the window once
" an entry is selected.
"nnoremap <F3> :TagbarOpenAutoClose<cr>
"nnoremap <F4> :TagbarToggle<cr><c-w>=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               delimitMate                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au vimrc FileType html,xhtml,markdown let b:delimitMate_matchpairs = "(:),[:],{:}"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              vim-css-color                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:cssColorVimDoNotMessMyUpdatetime = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  ALE                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Unlike syntastic, ALE supports async linting.
" NOTE: Fills Vim's location list with errors/warnings, NOT the quickfix list!

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" let g:ale_linters_explicit = 1
" let g:ale_completion_delay = 500
" let g:ale_echo_delay = 20
" let g:ale_lint_delay = 500

" We turn off everything except on-save because the other options add visible
" latency (at least for Markdown, haven't investigated further).
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'

"let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad cterm=undercurl ctermfg=red
hi! SpellCap cterm=undercurl ctermfg=blue
hi! SpellRare cterm=undercurl ctermfg=magenta


" Note: Overriden in work vim settings
let g:ale_linters = {
\   'python': ['flake8'],
\   'cpp': ['g++'],
\}

let g:ale_python_flake8_options = '--max-line-length=80 ' .
      \ '--max-complexity=10 --ignore=E111,E114,E121,E125,E126,E127,E128,E129,' .
      \ 'E131,E133,E201,E202,E203,E211,E221,E222,E241,E251,E261,E303,E402,W503'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              YouCompleteMe                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:ycm_server_python_interpreter='/usr/bin/python2'
"let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
"
"
"let g:ycm_clangd_uses_ycmd_caching = 1
"
"let g:ycm_filetype_blacklist = {
"      \ 'tagbar': 1,
"      \ 'notes': 1,
"      \ 'markdown': 1,
"      \ 'netrw': 1,
"      \ 'unite': 1,
"      \ 'text': 1,
"      \ 'vimwiki': 1,
"      \ 'pandoc': 1,
"      \ 'infolog': 1,
"      \ 'mail': 1,
"      \ 'hgcommit': 1,
"      \ 'gitcommit': 1
"      \}
"
"nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>
"nnoremap <leader>g :YcmCompleter GoTo<CR>
"nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
"nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>
"
"" Using <space> at the end to make it more visible and prevent trimming
"nnoremap <f6> :YcmCompleter RefactorRename<space>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Airline                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline_powerline_fonts = 1
let g:airline_theme = 'onedark'
" Removes the function name from the statusline; this helps prevent filename
" truncation.
let g:airline#extensions#tagbar#enabled = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            vim-indent-guides                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 7

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             MatchTagAlways                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:mta_use_matchparen_group = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 eregex                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:eregex_default_enable = 0

" Toggles '/' to mean eregex search or normal Vim search
nnoremap <leader>/ :call eregex#toggle()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          vim-instant-markdown                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:instant_markdown_autostart = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         vim-operator-highlight                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ophigh_filetypes_to_ignore = { "spansdl": 1 }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              vim-quickhl                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Doesn't work, so we do it manually with an au event
" let g:quickhl_cword_enable_at_startup = 1

"au vimrc BufEnter * :QuickhlCwordEnable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               NERDTree                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"nnoremap <F2> :NERDTree<cr>
"nnoremap <F2> :NERDTreeToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            vim-derish                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" nnoremap <Tab>7
" nnoremap <Tab>8
" nnoremap <Tab>9

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            vim-vinegar                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

noremap <silent><tab>6 :VinegarOpen leftabove vs<cr>
noremap <silent><tab>7 :VinegarOpen vs<cr>
noremap <silent><tab>8 :VinegarOpen belowright sp<cr>
noremap <silent><tab>9 :VinegarOpen tabedit<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              vim-signify                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set signcolumn=yes
" default updatetime 4000ms is not good for async update
set updatetime=100


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              emmet-vim                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:user_emmet_settings = {
\  'php' : {
\    'extends' : 'html',
\    'filters' : 'c',
\  },
\  'xml' : {
\    'extends' : 'html',
\  },
\}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              echodoc                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:echodoc_enable_at_startup = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           YouCompleteMe                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_server_python_interpreter='/usr/bin/python2'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" Also see the 'pumheight' vim option!
let g:ycm_max_num_identifier_candidates = 10
let g:ycm_complete_in_strings = 1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,perl': ['re!\w{2}'],
           \ 'lua,javascript': ['re!\w{2}'],
           \ }

nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              VIMRC OVERRIDE                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" If we are at our work workstation, then do some things differently
if at_work
  exec 'source ' . work_path
endif

" TODO: cleanup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              My Own  OVERRIDE                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf sometimes has bug
nnoremap <C-m> :bro ol<CR>

" complete quicker
inoremap <C-]> <C-X><C-]>
inoremap <C-F> <C-X><C-F>
inoremap <C-D> <C-X><C-D>
inoremap <C-L> <C-X><C-L>

" make comments and HTML attributes italic
highlight Comment cterm=italic term=italic gui=italic
highlight htmlArg cterm=italic term=italic gui=italic
highlight xmlAttrib cterm=italic term=italic gui=italic

"<F2>
"<F3>
"<F4> undotree toggle

"<F5> run program
"<F6>
"<F7> paste
"<F8> make

"<F9> compile cpp
"<F10> quickfix toggle
"<F11>
"<F12>
"

nnoremap <Tab> >>
nnoremap <S-Tab> <<

nnoremap gb :ls<CR>:b<Space>

"set path=.,**




" Conflict with UltiSnips
"*****************************************************************************
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
"*****************************************************************************
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
" inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
" inoremap <S-Tab> <C-n>

