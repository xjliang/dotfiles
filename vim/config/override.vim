"----------------------------------------------------------------------
" VIMRC OVERRIDE
"----------------------------------------------------------------------

" If we are at our work workstation, then do some things differently
if at_work
  exec 'source ' . work_path
endif


"----------------------------------------------------------------------
" make comments and HTML attributes italic
"----------------------------------------------------------------------
highlight Comment cterm=italic term=italic gui=italic
highlight htmlArg cterm=italic term=italic gui=italic
highlight xmlAttrib cterm=italic term=italic gui=italic


" Conflict with UltiSnips
"----------------------------------------------------------------------
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
"----------------------------------------------------------------------
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

