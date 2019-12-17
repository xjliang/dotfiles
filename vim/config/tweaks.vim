"----------------------------------------------------------------------
"                          More involved tweaks
"----------------------------------------------------------------------

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

" Sometimes, $MYVIMRC does not get set even though the vimrc is sourced
" properly. So far, I've only seen this on Linux machines on rare occasions.
if has("unix") && strlen($MYVIMRC) < 1
  let $MYVIMRC=$HOME . '/.vimrc'
endif

" cindent is a bit too smart for its own good and triggers in text files when
" you're typing inside parens and then hit enter; it aligns the text with the
" opening paren and we do NOT want this in text files!
au vimrc FileType text,markdown,gitcommit,hgcommit set nocindent

au vimrc FileType markdown setlocal spell! spelllang=en_us

" Open epub files as if they were zip files (because they are)
au vimrc BufReadCmd *.epub call zip#Browse( expand( "<amatch>" ) )

