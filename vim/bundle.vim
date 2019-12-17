"----------------------------------------------------------------------
" Vim-PLug core
"----------------------------------------------------------------------
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

let g:vim_bootstrap_langs = "c,haskell,html,javascript,lua,perl,php,python"
let g:vim_bootstrap_editor = "vim"				" nvim or vim

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

"----------------------------------------------------------------------
" Plug install packages
"----------------------------------------------------------------------
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

Plug 'Raimondi/delimitMate'
Plug 'anyakichi/vim-surround'
Plug 'Valloric/MatchTagAlways', { 'for': 'html' }
Plug 'michaeljsmith/vim-indent-object'
Plug 'godlygeek/tabular'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'vim-scripts/matchit.zip'
Plug 'mileszs/ack.vim'
Plug 'dense-analysis/ale', {'for': ['c', 'cpp', 'python']}
Plug 'vim-scripts/FSwitch', {'for': ['c', 'cpp']}
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/YankRing.vim'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}

Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif


"" File explore
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-vinegar'

Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/asyncrun.vim', {'for': ['c', 'cpp']}
Plug 'skywind3000/vim-preview'

"" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'Valloric/vim-operator-highlight'
"Plug 'Valloric/vim-valloric-colorscheme'

"Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp' }
Plug 'othree/html5.vim', {'for': 'html', 'on': []}
Plug 'mattn/emmet-vim', {'for': ['html', 'php']}
Plug 'skammer/vim-css-color', {'for': 'css', 'on': []}
Plug 'hail2u/vim-css3-syntax', {'for': 'css', 'on': []}
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'Valloric/python-indent', {'for': 'python'}
Plug 'vim-scripts/python.vim', {'for': 'python'}
Plug 'vim-scripts/python_match.vim', {'for': 'python'}


if !at_work
  Plug 'Shougo/echodoc.vim', {'for': ['c', 'cpp']}
  Plug 'ycm-core/YouCompleteMe', {'for': ['c', 'cpp']}
endif

call plug#end()

augroup load_html
    autocmd!
    autocmd InsertEnter * call plug#load('html5.vim') | autocmd! load_html
    autocmd InsertEnter * call plug#load('vim-css3-syntax') | autocmd! load_html
    autocmd InsertEnter * call plug#load('vim-css-color') | autocmd! load_html
augroup END


"----------------------------------------------------------------------
" reset vimrc augroup
"----------------------------------------------------------------------

" We reset the vimrc augroup. Autocommands are added to this group throughout
" the file
augroup vimrc
  au!
augroup END


"----------------------------------------------------------------------
" turn on filetype plugins
"----------------------------------------------------------------------

" Enable detection, plugins and indenting in one step
" This needs to come AFTER the Plugin commands!
filetype plugin indent on
