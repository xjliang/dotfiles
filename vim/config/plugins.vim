"----------------------------------------------------------------------
"                    *** HERE BE PLUGINS ***
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" LeaderF
"----------------------------------------------------------------------

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1

" let g:Lf_ShortcutB = '<m-n>'
" noremap <m-m> :LeaderfTag<cr>

let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
			\ }

let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
let g:Lf_MruMaxFiles = 2048
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

let g:Lf_NormalMap = {
        \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
		\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
		\ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
		\ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
		\ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
		\ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
		\ }

"----------------------------------------------------------------------
" undotree
"----------------------------------------------------------------------

" f5 toggles the Gundo plugin window
let g:undotree_width=80


"----------------------------------------------------------------------
" gutentags
"----------------------------------------------------------------------

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


"----------------------------------------------------------------------
" asyncrun
"----------------------------------------------------------------------

let g:asyncrun_open = 6
let g:asyncrun_bell = 1
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']


"----------------------------------------------------------------------
" yankring
"----------------------------------------------------------------------

let g:yankring_history_dir = '$HOME/.cache'
" this is so that single char deletes don't end up in the yankring
let g:yankring_min_element_length = 2
let g:yankring_window_height = 14


"----------------------------------------------------------------------
" session
"----------------------------------------------------------------------
" you also need to run :SaveSession once to create the default.vim session that
" will then be autoloaded/saved from then on

let g:session_autoload        = 'no'
let g:session_autosave        = 'yes'
let g:session_default_to_last = 'yes'
let g:session_directory       = '~/tmp/vim/sessions'


"----------------------------------------------------------------------
" UltiSnips
"----------------------------------------------------------------------

" we can't use <tab> as our snippet key since we use that with YouCompleteMe
let g:UltiSnipsSnippetsDir         = $HOME . '/dotfiles/vim/UltiSnips'
let g:UltiSnipsExpandTrigger       = "<m-e>"
let g:UltiSnipsJumpForwardTrigger  = "<m-n>"
let g:UltiSnipsJumpBackwardTrigger = "<m-p>"
let g:UltiSnipsListSnippets        = "<m-m>"
let g:UltiSnipsJumpForwardTrigger  = "<right>"
let g:UltiSnipsJumpBackwardTrigger = "<left>"
let g:snips_author                 = 'Strahinja Val Markovic'

" NOTE: To get a snippet to expand in-word (for instance, within parens), add
" the letter "i" after the snippet header. Ex: snippet ss "std::string" i


"----------------------------------------------------------------------
" ack.vim
"----------------------------------------------------------------------

if executable('ag')
    "let g:ackprg = "ag --nocolor --nogroup --column"
    " Note we extract the column as well as the file and line number
    " Have the silver searcher ignore all the same things as wilgignore
    let b:ag_command = 'ag %s -i --nocolor --nogroup'

    for i in split(&wildignore, ",")
      let i = substitute(i, '\*/\(.*\)/\*', '\1', 'g')
      let b:ag_command = b:ag_command . ' --ignore "' . substitute(i, '\*/\(.*\)/\*', '\1', 'g') . '"'
    endfor

    let b:ag_command = b:ag_command . ' --hidden -g ""'
    let g:ctrlp_user_command = b:ag_command
elseif executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
elseif executable('ack-grep')
  let g:ackprg = "ack-grep --nocolor --nogroup --column"
elseif executable('ack')
  let g:ackprg = "ack --nocolor --nogroup --column"
endif

cnoreabbrev Ack Ack!
let g:ackhighlight = 1


"----------------------------------------------------------------------
" fswitch
"----------------------------------------------------------------------

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


"----------------------------------------------------------------------
" vim-git
"----------------------------------------------------------------------

" Turn on spell checking by default for git commit messages
au vimrc FileType gitcommit setlocal spell! spelllang=en_us


"----------------------------------------------------------------------
" delimitMate
"----------------------------------------------------------------------

au vimrc FileType html,xhtml,markdown let b:delimitMate_matchpairs = "(:),[:],{:}"


"----------------------------------------------------------------------
" vim-css-color
"----------------------------------------------------------------------

let g:cssColorVimDoNotMessMyUpdatetime = 1


"----------------------------------------------------------------------
" Ale
"----------------------------------------------------------------------

" Unlike syntastic, ALE supports async linting.
" NOTE: Fills Vim's location list with errors/warnings, NOT the quickfix list!

let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'

" We turn off everything except on-save because the other options add visible
" latency (at least for Markdown, haven't investigated further).
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'normal'
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


"----------------------------------------------------------------------
" Airline
"----------------------------------------------------------------------

let g:airline_powerline_fonts = 1
let g:airline_theme = 'onedark'
" Removes the function name from the statusline; this helps prevent filename
" truncation.
let g:airline#extensions#tagbar#enabled = 0


"----------------------------------------------------------------------
" MatchTagAlways
"----------------------------------------------------------------------

let g:mta_use_matchparen_group = 0


"----------------------------------------------------------------------
" vim-operator-highlight
"----------------------------------------------------------------------

let g:ophigh_filetypes_to_ignore = { "spansdl": 1 }


"----------------------------------------------------------------------
" Signify
"----------------------------------------------------------------------

let g:signify_vcs_list = ['git', 'svn']
let g:signify_difftool = 'diff'
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = g:signify_sign_change
let g:signify_as_gitgutter           = 1

let g:signify_vcs_cmds = {
            \ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
            \}


"----------------------------------------------------------------------
" Emmet
"----------------------------------------------------------------------

let g:user_emmet_settings = {
\  'php' : {
\    'extends' : 'html',
\    'filters' : 'c',
\  },
\  'xml' : {
\    'extends' : 'html',
\  },
\}


"----------------------------------------------------------------------
" echodoc
"----------------------------------------------------------------------

let g:echodoc_enable_at_startup = 1


"----------------------------------------------------------------------
" YouCompleteMe
"----------------------------------------------------------------------

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


