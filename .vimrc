" vim: fdm=marker foldenable sw=4 ts=4 sts=4
" xjliang's .vimrc File
" Last Modify: Thu Dec 19 10:26:36 DST 2019
" "zo" to open folds, "zc" to close, "zn" to disable.

" {{{ Preamble

set runtimepath+=~/dotfiles/vim

" Clear all autocommands

" TODO: It might be more honest to put this in my ,v auto-source-vimrc binding
au!

" clear group for later use
augroup vimrc
    au!
augroup END

" }}}

" {{{ Basic Settings

let mapleader=' '
let g:mapleader=' '

" Modelines
set modelines=2
set modeline

" {{{ Jump files/buffers & Grep

" For clever completion with te :find command
set path=.,**
nnoremap <leader>f :find *
"nnoremap <leader>s :sfind *
"nnoremap <leader>v :vert sfind *
"nnoremap <leader>t :tabfind *

nnoremap <leader>F :find <C-R>=expand('%:h').'/*'<CR>
"nnoremap <leader>S :sfind <C-R>=expand('%:h').'/*'<CR>
"nnoremap <leader>V :vert sfind <C-R>=expand('%:h').'/*'<CR>
"nnoremap <leader>T :tabfind <C-R>=expand('%:h').'/*'<CR>

set wildcharm=<C-z>
nnoremap <leader>b :buffer <C-z><S-Tab>
nnoremap <leader>B :sbuffer <C-z><S-Tab>

nnoremap <leader>j :tjump /

" Search {{{
set smartcase ignorecase
set hlsearch incsearch

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nocolor\ --nogroup\ --column\ -i
endif
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" }}}

" }}}

" Window display
set showcmd ruler laststatus=2

" Splits
set splitright

" Buffers
set history=500  " set how manyines of history VIM has to remember
set hidden
if exists("&undofile")
    set undolevels=1000
    set undofile
endif

" Backups {{{

if has('win32')
    " Windows filesystem
    set directory=$HOME\VimBackups\swaps,$HOME\VimBackups,C:\VimBackups,
    set backupdir=$HOME\VimBackups\backups,$HOME\VimBackups,C:\VimBackups,
    if exists("&undodir")
        set undodir=$HOME\VimBackups\undofiles,$HOME\VimBackups,C:\VimBackups,
    endif
    if has("gui_running")
      set guifont=Inconsolata:h12:cANSI
    endif
else
    " POSIX filesystem
    set directory=$HOME/.backups/swaps,$HOME/.backups,$HOME/tmp,.
    set backupdir=$HOME/.backups/backups,$HOME/.backups,$HOME/tmp,.
    if exists("&undodir")
        set undodir=$HOME/.backups/undofiles,$HOME/.backups,$HOME/tmp,.
    endif
endif

" }}}
" TODO
" Spelling
set dictionary+=/usr/share/dict/words thesaurus+=$HOME/.vim/thesaurus/thesaurii.txt

" Text display
set listchars=trail:.,tab:>-,extends:>,precedes:<,nbsp:¬
set list

" Typing behavior
set backspace=indent,eol,start
set showmatch
"set wildmode=full
set wildmode=longest,list,full
set wildmenu
set complete-=i

" Formatting
set nowrap
set tabstop=4 shiftwidth=4 softtabstop=4
set foldlevelstart=2
"set foldmethod=syntax

" Status line
"set statusline=%!MyStatusLine()

" TODO
" Session saving
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,localoptions

" Word splitting
set iskeyword+=_,$,@,%,#
"set iskeyword+=-

" Enable filtype plugins
filetype on
filetype indent on
filetype plugin on

" auto read file when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

set title

" all folds open by default
"set foldlevelstart=99

" Right-click on selection should bring up a menu
set mousemodel=popup_setpos

" this makes sure that shell scripts are highlighted
" as bash scripts and not sh scripts
let g:is_posix = 1

" don't need to press enter to skip startup
set shortmess=atI

" for ctags
set tags=./.tags;.tags
set tags+=~/.vim/tags/cpp

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extras=+q . -f .tags<CR>

" show color column
set textwidth=80
set colorcolumn=+1
highlight ColorColumn ctermbg=235

set formatoptions=tcroqnj
set pumheight=10

" Turn backup off, since most stuff is in Git, SVN etc.
set nobackup
set noswapfile

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" file mode is unix
set fileformat=unix

" detects unix, dos, mac file formats in that order
set fileformats=unix,dos,mac

set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo
                        " file -- 20 jump links, regs up to 500 lines'

" set 7 lines to the cursor - when moving vertically
set so=7

set langmenu=en

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.svn/*,*/.DS_Store

" show matching brackets when text indicator is over them
" match time
set mat=2

" Height of command bar
set cmdheight=2

" Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l


" don't redraw while executing macros (good performance config)
set lazyredraw

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
"set foldcolumn=1

" }}}

" {{{ Autocommands

" set cursorline
autocmd InsertEnter,InsertLeave * set cul!

" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
" Only work for VTE compatible terminals (urxvt, st, xterm, gnome-terminal 3.x, Konsole
" KDE5 and others)
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Make the modification indicator [+] white on red background
au ColorScheme * hi User1 gui=bold term=bold cterm=bold guifg=white guibg=red ctermfg=white ctermbg=red

" Tweak the color of the fold display column
au ColorScheme * hi FoldColumn cterm=bold ctermbg=233 ctermfg=146

" TODO: ???
" create two empty side buffers to make the diary text width more readable,
" without actually setting a hard textwidth which requires inserting CR's
au VimEnter */diary/*.txt vsplit | vsplit | enew | vertical resize 50 | wincmd t | enew | vertical resize 50 | wincmd l

" Spaces Only
au FileType markdown,cpp,hpp,vim,sh,html,css,sass,scss,javascript,coffee,python setl expandtab list

" Tabs Only
au FileType c,h,make setl foldmethod=syntax noexpandtab nolist
au FileType gitconfig,apache,sql setl noexpandtab nolist

" Folding
au FileType html,css,sass,javascript,python setl foldmethod=indent foldenable
au FileType json setl foldmethod=indent foldenable shiftwidth=4 softtabstop=4 tabstop=4 expandtab

" Other
au FileType python let b:python_highlight_all=1
au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType diary setl wrap linebreak nolist

au FileType markdown setl linebreak
let vim_markdown_folding_disabled = 1

" Auto saving! Having used Intellij IDEA, autosave is the only way to go
set autowriteall
au FocusLost * silent! wa

au vimrc BufEnter *.snippets setf snippets
au vimrc BufEnter *.tpl setf html
au vimrc BufEnter *.acl setf yaml
au vimrc BufEnter *.gradle setf groovy
au vimrc BufEnter *.pdsc setf json
au vimrc BufEnter *.conf setf conf

"au vimrc BufLeave *.css  normal! mC
"au vimrc BufLeave *.html normal! mH
"au vimrc BufLeave *.js   normal! mJ
"au vimrc BufLeave *.php  normal! mP
au vimrc BufLeave *.vim  normal! mV
au vimrc BufLeave *.sh   normal! mS
au vimrc BufLeave *.py   normal! mP
au vimrc BufLeave *.c    normal! mC
au vimrc BufLeave *.h    normal! mH
au vimrc BufLeave *.vimrc  normal! mR

" TODO: understand
" Make sure that enter is never overriden in the quickfix window
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Source: https://vi.stackexchange.com/a/456
fun! s:TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

" Automatically delete trailing DOS-returns and whitespace on file open and
" write.
au vimrc BufRead,BufWritePre,FileWritePre * silent! call s:TrimWhitespace()

au vimrc FileType snippets set noexpandtab

au vimrc FileType c
      \ set tabstop=8 |
      \ set shiftwidth=8 |
      \ set softtabstop=8

au vimrc FileType cpp
      \ set tabstop=2 |
      \ set shiftwidth=2 |
      \ set softtabstop=2


au vimrc FileType python
      \ set tabstop=4 |
      \ set shiftwidth=4 |
      \ set softtabstop=4

if exists('$TMUX')
    set term=screen-256color
endif

" }}}

" Misc (abbr, enhanced key mapping but no need to keep in mind) {{{

" abbreviations
iab xdate <C-r>=strftime("%d/%m%y %H:%M:%S")<cr>

" move to first non-empty word
nnoremap 0 ^

" Yank from current position to end of line just like D, C
nnoremap Y y$

" center the screen
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap g; g;zz
nnoremap g, g,zz

" this makes vim's regex engine -not stupid-
" see :h magic
nnoremap / /\v
vnoremap / /\v

" easier switch to normal mode
inoremap ,. <Esc>
vnoremap ,. <Esc>

" jump to marker
nnoremap ' `
nnoremap ` '

" swap : and ;
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

nnoremap j gj
nnoremap k gk

" quicker scrolling
nnoremap <c-e> 5<c-e>
nnoremap <c-y> 5<c-y>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" }}}

" Key Mappings {{{

" Run shell command
" ... and print output
nnoremap <C-h> :.w !bash<CR>
" ... and append output
nnoremap <C-l> yyp!!bash<CR>

" Easy quickfix navigation
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>

" Easy header/source swap
nnoremap [f :call SourceHeaderSwap()<CR>

" Select the stuff I just pasted
nnoremap gV `[V`]

" Create a new HTML document.
nnoremap <leader>html :-1read $HOME/.vim/.skeleton.html<CR>6jwf>a

" camelCase => camel_case
vnoremap ,case :s/\v\C(([a-z]+)([A-Z]))/\2_\l\3/g<CR>

" Quick modeline insert
nnoremap \m ggOvim: et nolist sw=4 ts=4 sts=4<ESC>

" Swap order of Python function arguments
nnoremap <silent> ,- :%s/\(self\.\)\?<C-R><C-W>(\(self, \)\?\([a-zA-Z]\+\), \?\([a-zA-Z]\+\))/\1<C-R><C-W>(\2\4, \3)/g<CR>

" Swap tab/space mode
nnoremap ,<TAB> :set et! list!<CR>




" => Files {{{2

    " Fast saving
    nnoremap <leader>w :w!<cr>

    nnoremap <leader>q :q<cr>

    " handle permission-denied error
    cnoremap w!! !sudo tee % >/dev/null

    " Fast editing and reloading of vimrc configs
    noremap <leader>ev :tabnew $MYVIMRC<CR>
    noremap <silent> <leader>E :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" }}}

" => Windows {{{2

    " quicker move between windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

    " split
    nnoremap <leader>v :vs<CR>
    nnoremap <leader>h :sp<CR>

    " resize
    nnoremap <leader>= 15<c-w>+  " expand vertically
    nnoremap <leader>- 15<c-w>-  " shrink vertically

    " quicker close
    nnoremap <leader>c <c-w>c    " close current window
    nnoremap <leader>o <c-w>o    " close other window

" }}}

" => Buffers {{{2

    "switch CWD to the directory of the open buffer
    nnoremap <leader>cd :cd%:p:h<cr>:pwd<cr>

    " close current buffer
    map <leader>bd :bdelete<cr>

    " close current buffer before switching to previous buffer
    nnoremap <leader>bq <c-^> :bd #<cr>

    " close all buffers
    map <leader>ba :bufdo bd<cr>

    " list buffers and switch to one of them
    nnoremap gb :ls<CR>:b<Space>

" }}}

" => Tabs {{{2

    nnoremap <leader>tn :tabnew<cr>
    nnoremap <leader>tc :tabclose<cr>
    nnoremap <leader>to :tabonly<cr>
    nnoremap [t :tabnext<cr>
    nnoremap ]t :tabprevious<cr>
    nnoremap <leader>tm :tabmove

" }}}

" => Editor {{{2

    " Disable highlight when <backspace> is pressed
    nnoremap <silent> <backspace> :nohl<cr>

    " create newlines like o & O but stay in normal mode
    nnoremap <silent> zj o<Esc>k
    nnoremap <silent> zk O<Esc>j

    " fast complete
    " filename
    inoremap <C-f> <C-x><C-f>
    " line
    inoremap <C-l> <C-x><C-l>
    " tags
    inoremap <C-]> <C-x><C-]>
    " thesaurus
    inoremap <C-t> <C-x><C-t>
    " included files
    inoremap <C-i> <C-x><C-i>
    " macros
    inoremap <C-d> <C-x><C-d>

    " format paragraph
    vnoremap Q gq
    nnoremap Q gqap

    " Change indent continuously
    vmap < <gv
    vmap > >gv

" }}}

" => commond mode {{{2

    cno $h e ~/
    cno $d e ~/Desktop/
    cno $j e ./

    " bash like keys for command line
    cnoremap <C-A> <Home>
    cnoremap <C-E> <End>
    cnoremap <C-K> <C-U>
    cnoremap <C-P> <UP>
    cnoremap <C-N> <Down>

" }}}

" => Spell checking {{{2

    noremap <leader>ss :setlocal spell! spelllang=en_us<cr>
    noremap <leader>sn ]s
    noremap <leader>sp [s
    noremap <leader>sa zg
    noremap <leader>su z=

" }}}

" browse Most Recent Used file (MRU) {{{
nnoremap <leader>m :bro ol<cr>
" }}}

" unimpaired (toggle between configurations) {{{

" jump to previous/next buffer
nnoremap [b :bp<cr>
nnoremap ]b :bn<cr>

nnoremap [n :set number<cr>
nnoremap ]n :set number!<cr>

nnoremap [l :set list<cr>
nnoremap ]l :set list!<cr>

nnoremap [w :set wrap<cr>
nnoremap ]w :set wrap!<cr>
" }}}

" Completion {{{
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction

inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>
" }}}

" }}}

" Theme {{{

" This has to happen AFTER autocommands are defined, because I run au! when,
" defining them, and syntax hilighting is done with autocommands.

" Syntax hilighting
syntax enable

syntax on
set background=light

try
    colorscheme PaperColor
catch
    colorscheme delek
endtry

" }}}

" Custom Functions {{{

" visualselection {{{
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" }}}

" Zoom / Restore window. {{{
" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction

command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>

" }}}

" Highlight Interesting Words {{{
  " This mini-plugin provides a few mappings for highlighting words temporarily.
  function! HiInterestingWord(n)
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  It is also used in `ClaerAllHi`.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
  endfunction

  "clear all highlighting
  function! ClearAllHi()
      for i in range(1,6)
          let mid = 86750 + i
          silent! call matchdelete(mid)
      endfor
  endfunction

  nnoremap <silent> <leader>0 :call ClearAllHi()<cr>
  nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
  nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
  nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
  nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
  nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
  nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

  hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
  hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
  hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
  hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
  hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
  hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" }}}

" MyStatusLine() {{{

function! MyStatusLine()
    let statusline = " "
    " Filename (F -> full, f -> relative)
    let statusline .= "%f"
    " Buffer flags
    let statusline .= "%( %h%1*%m%*%r%w%) "
    " File format and type
    let statusline .= " %(%Y%) [%{&ff}] "
    " Left/right separator
    let statusline .= "%="
    "let statusline .= "%#CursorColumn#"
    " Line & column
    let statusline .= "(%l: %c%V) "
    " File progress
    let statusline .= "| %P/%L "
    return statusline
endfunction

set laststatus=2
set statusline=
set statusline+=\ %f\ %*
set statusline+=\ ››
set statusline+=\ %(%h%1*%m%*%r%w%)
"set statusline+=\ %(%h%1*%m%*%r%w%)%
set statusline+=%=
set statusline+=\ ‹‹
set statusline+=\ %(%Y%)
set statusline+=\ [%{&fileformat}\]
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ ::
set statusline+=\ %*
set statusline+=\ %l\ :\ %c
set statusline+=\ %*

" }}}

" Source/Header Swap {{{
function! SourceHeaderSwap()
    if expand('%:h') == 'content/ui'
        execute ":edit mods/base/ui/".expand('%:t:r').".py"
    elseif expand('%:h') == 'mods/base/ui'
        execute ":edit content/ui/".expand('%:t:r').".html"
    elseif expand('%:e') == 'h'
        if filereadable(expand('%:r').".cpp")
            execute ":edit ".expand('%:r').".cpp"
        else
            execute ":edit ".expand('%:r').".c"
        endif
    else
        edit %<.h
    endif
endfunction
" }}}

" }}}

" {{{ netrw: Configuration
"     ====================

function! s:open(cmd) abort
    let filename = expand('%:p')
    let shortname = expand('%:t')
    if &buftype == "nofile" || &buftype == "quickfix"
        if (&ft != 'netrw')
            return
        endif
    endif
    if &filetype ==# 'netrw'
        if s:netrw_up == ''
            return
        endif
        let currdir = fnamemodify(b:netrw_curdir, ':t')
        let nextdir = fnamemodify(b:netrw_curdir, ':h:p')
        if s:windows && strlen(nextdir) == 3
            let t = strpart(nextdir, 1, 2)
            if t == ':/' || t == ":\\"
                let t = nextdir . '.'
                if tolower(nextdir) != tolower(b:netrw_curdir)
                    execute a:cmd t
                    "call s:seek(currdir)
                endif
                return
            endif
        endif

        try
            exec s:netrw_up
        catch
        endtry

        "call s:seek(currdir)
    elseif &modifiable == 0 && &ft != 'help'
        return
    elseif shortname == ""
        exec a:cmd '.'
    elseif expand('%') =~# '^$\|^term:[\/][\/]'
        exec a:cmd '.'
    else
        exec a:cmd '%:p:h'
        "let hr = s:seek(filename)
    endif
endfunc

command! -nargs=1 VinegarOpen call s:open(<f-args>)

noremap <silent>- :e .<cr>
noremap <silent><tab>6 :VinegarOpen leftabove vs<cr>
noremap <silent><tab>7 :VinegarOpen vs<cr>
noremap <silent><tab>8 :VinegarOpen belowright sp<cr>
noremap <silent><tab>9 :VinegarOpen tabedit<cr>

let g:netrw_liststyle = 1
let g:netrw_winsize = 25
"let g:netrw_hide = 1
"let g:netrw_list_hide = '^\.\.\=/\=$,\.swp\($\|\t\),\.py[co]\($\|\t\),\.o\($\|\t\),\.bak\($\|\t\),\(^\|\s\s\)\zs\.\S\+'
"let g:netrw_list_hide= '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\./$'
let g:netrw_list_hide = '^\..*'        " or anything you like
let g:netrw_hide = 1                   " hide by default

let g:netrw_sort_sequence = '[\/]$,*,\.bak$,\.o$,\.info$,\.swp$,\.obj$'
let g:netrw_preview = 0
let g:netrw_special_syntax = 1
let g:netrw_sort_options = 'i'

if isdirectory(expand('~/.vim'))
    let g:netrw_home = expand('~/.vim')
endif

let g:netrw_timefmt = "%Y-%m-%d %H:%M:%S"

let g:netrw_banner=0
"let g:netrw_browse_split=4   " open in prior window
let g:netrw_altv=1           " open splits to the right
"let g:netrw_liststyle=3      " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()

let s:ignore = ['.o', '.obj', '.so', '.a', '~', '.tmp', '.egg', '.class', '.jar']
let s:ignore += ['.tar.gz', '.zip', '.7z', '.bz2', '.rar', '.jpg', '.png']
let s:ignore += ['.chm', '.docx', '.xlsx', '.pptx', '.pdf', '.dll', '.pyd']

for s:extname in s:ignore
    let s:pattern = escape(s:extname, '.~') . '\($\|\t\),'
    " let g:netrw_list_hide = s:pattern . g:netrw_list_hide
endfor

let s:pattern = '#.\{-\}#\($\|\t\),'
if has('win32') || has('win16') || has('win95') || has('win64')
    let s:pattern .= '\$.\{-\}\($\|\t\),'
endif

" let g:netrw_list_hide = s:pattern . g:netrw_list_hide

" fixed netrw underline bug in vim 7.3 and below
if v:version < 704
    "set nocursorline
    "au FileType netrw hi CursorLine gui=underline
    "au FileType netrw au BufEnter <buffer> hi CursorLine gui=underline
    "au FileType netrw au BufLeave <buffer> hi clear CursorLine
    autocmd BufEnter * if &buftype == '' | :set nocursorline | endif
endif

"let g:ft_man_open_mode = 'vert'


" }}}

" Intial Plugin {{{

" install bundles
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif

" }}}

" Local Settings {{{

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

set exrc
set secure

" }}}

" That's all :)
