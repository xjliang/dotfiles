"----------------------------------------------------------------------
" Last modification: Tue Dec 17 10:45:17 DST 2019
"
" Guided by vim-bootstrap: https://github.com/avelino/vim-bootstrap
" Change your ~/.vimrc as follows:
"   set runtimepath+=<path to this repository>
"   source <path to this repository>/vimrc
"----------------------------------------------------------------------

"----------------------------------------------------------------------
" preamble
"----------------------------------------------------------------------
let work_path = $HOME . '/work/work_vim_settings.vim'
let at_work = filereadable( work_path )

let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
command! -nargs=1 IncScript exec 'source '.s:home.'/'.'<args>'
exec 'set rtp+='.s:home

IncScript bundle.vim
IncScript config/config.vim

IncScript config/general.vim
IncScript config/tweaks.vim
IncScript config/ignores.vim
IncScript config/keymaps.vim
IncScript config/plugins.vim
IncScript config/override.vim

