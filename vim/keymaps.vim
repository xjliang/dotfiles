"*****************************************************************************
" Last modification: Tue Dec 17 00:26:46 DST 2019
"
" Guided by vim-bootstrap: https://github.com/avelino/vim-bootstrap
" Change your ~/.vimrc as follows:
"   set runtimepath+=<path to this repository>
"   source <path to this repository>/vimrc
"*****************************************************************************
" NOTE: a lot of these mappings won't make sense until you realize I'm using a
" "Dvorak-Qwerty Command" layout (and similar on Win/Lin). The layout is Dvorak
" unless you hold down Ctrl or Alt or Cmd; then it changes to Qwerty. This type
" of layout gives us Dvorak typing but Qwerty keyboard shortcuts.

" our <leader> will be the space key
let mapleader=" "

" our <localleader> will be the '-' key
let maplocalleader="-"

"" LeaderF
let g:Lf_ShortcutF = '<leader>f'
noremap <leader>m :LeaderfMru<cr>

" Fast saving
nnoremap <leader>w :w!<cr>

" <leader>v brings up .vimrc
" <leader>V reloads it and makes all changes active (file has to be saved first)
noremap <leader>e :e! $MYVIMRC<CR>
noremap <silent> <leader>E :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

"" asyncrun
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <silent> <F8> :AsyncRun -cwd=<root> make <cr>
nnoremap <silent> <F9> :AsyncRun g++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

"" vinegar
noremap <silent><tab>6 :VinegarOpen leftabove vs<cr>
noremap <silent><tab>7 :VinegarOpen vs<cr>
noremap <silent><tab>8 :VinegarOpen belowright sp<cr>
noremap <silent><tab>9 :VinegarOpen tabedit<cr>

nnoremap <F4> :UndotreeToggle<CR>


"" Ack
nnoremap <Leader>a :Ack!<Space>

"" Split
nnoremap <leader>v :vs<CR>
nnoremap <leader>h :sp<CR>

" fzf sometimes has bug
nnoremap <C-m> :bro ol<CR>

nnoremap <Tab> >>
nnoremap <S-Tab> <<

nnoremap gb :ls<CR>:b<Space>

" complete quicker
inoremap <C-]> <C-X><C-]>
inoremap <C-F> <C-X><C-F>
inoremap <C-D> <C-X><C-D>
inoremap <C-L> <C-X><C-L>


" This is quit all
noremap <leader>q :qa<cr>

"" YankRing
nnoremap <leader>r :YRShow<CR>
" this makes Y yank from the cursor to the end of the line, which makes more
" sense than the default of yanking the whole current line (we can use yy for
" that)
fun! YRRunAfterMaps()
  nnoremap Y :<C-U>YRYankCount 'y$'<CR>
endfunction

"" YCM
nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>

" looks at the current line and the lines above and below it and aligns all the
" equals signs; useful for when we have several lines of declarations
nnoremap <leader>t= :Tabularize /=<CR>
vnoremap <leader>t= :Tabularize /=<CR>
nnoremap <leader>t/ :Tabularize /\/\//l2c1l0<CR>
vnoremap <leader>t/ :Tabularize /\/\//l2c1l0<CR>
nnoremap <leader>t, :Tabularize /,/l0r1<CR>
vnoremap <leader>t, :Tabularize /,/l0r1<CR>

" Switches to the previous buffer that was shown in the current window, but also
" closes the current buffer before switching to the previous one
noremap <leader>bq <c-^> :bd #<cr>

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

" this makes vim's regex engine "not stupid"
" see :h magic
nnoremap / /\v
vnoremap / /\v


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
"
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

" key bindings for quickly moving between windows
" h left, l right, k up, j down
noremap <C-h> <c-w>h
noremap <C-l> <c-w>l
noremap <C-k> <c-w>k
noremap <C-j> <c-w>j

" for faster scrolling
" TODO: create a command for scrolling by ~70% of the window height
noremap <c-e> 5<c-e>
noremap <c-y> 5<c-y>


nnoremap <backspace> :nohl<CR>

" Using '<' and '>' in visual mode to shift code by a tab-width left/right by
" default exits visual mode. With this mapping we remain in visual mode after
" such an operation.
vnoremap < <gv
vnoremap > >gv
