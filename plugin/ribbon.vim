" ribbon.vim - Browse the latest git repo changes
" Maintainer:  Eric Johnson <http://kablamo.org>
" Version:     0.01

let g:RibbonBufname='Ribbon'

let s:bufnr=0

function! s:openWindow()
    let l:bufwinnr = bufwinnr(s:bufnr)
    if l:bufwinnr == winnr()
        " viewport wth buffer already active and current
        return
    else
        " viewport with buffer exists, but not current
        execute(l:bufwinnr . " wincmd w")
    endif
endfunction

function! s:Ribbon()
    " open existing window if buffer exists and is open
    if bufwinnr(s:bufnr) > 0
        return s:openWindow()
    endif

    new
    let l:fileCmd='file ' . g:RibbonBufname
    execute l:fileCmd
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nowrap
    set bufhidden=hide
    setlocal nobuflisted
    setlocal nolist
    setlocal noinsertmode
    setlocal nonumber
    setlocal cursorline
    setlocal nospell
    setlocal matchpairs=""
    noremap <buffer> <silent> q :bdelete<cr>
    noremap <buffer> <silent> d :call ribbon#diff()<cr>

    let l:cmd = 'silent 0read ! git log --pretty=format:''\%an (\%cr) \%p:\%h\%n\%s'' --name-only --no-merges --reverse --topo-order _ribbon..origin/master'
    execute l:cmd
    normal 1G

    let s:bufnr = bufnr(g:RibbonBufname)
endfunction

function! ribbon#diff()
    let l:lineNr = search(') \(\w\+:\w\+\)$', 'b')
    let l:r      = submatch(1)
    echo l:r
    " let l:cmd    = 'Gdiff -r ' + l:r
    " execute l:cmd
endfunction

function! s:RibbonSave()
    silent !git tag --force _ribbon origin/master
    redraw!
endfunction

command! Ribbon     :call s:Ribbon()
command! RibbonSave :call s:RibbonSave()


