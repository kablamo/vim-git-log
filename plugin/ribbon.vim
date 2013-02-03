" ribbon.vim - Browse the latest git repo changes
" Maintainer:  Eric Johnson <http://kablamo.org>
" Version:     0.01
"
" TODO: 
"  - move cursor back to original position at the end of ribbon#diff()
"  - easy quit from diff OR easy return to Ribbon window
"  - do I still need openWindow?  probably want :Ribbon and :RibbonToggle?

let g:RibbonBufname='Ribbon'
let g:RibbonHeight=10

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

    let l:cmd = 'edit ' . g:RibbonBufname
    execute l:cmd
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nowrap
    "set bufhidden=hide
    "setlocal nobuflisted
    "setlocal nolist
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
    " get filename to diff
    let l:filename = getline(".")

    " get revisions
    let l:lineNr    = search(') \(\w\+:\w\+\)$', 'b')
    let l:line      = getline(l:lineNr)
    let l:revisions = substitute(l:line, '.*) \(\w\+:\w\+\)$', '\=submatch(1)', "")
    let l:rev       = split(l:revisions, ':')

    " do split 1
    "topleft split
    let l:gitCmd = 'Git! show ' . l:rev[0] . ':' . l:filename
    execute l:gitCmd
    diffthis

    " do split 2
    vsplit
    let l:gitCmd  = 'Git! show ' . l:rev[1] . ':' . l:filename
    execute l:gitCmd
    diffthis
endfunction

function! s:RibbonSave()
    silent !git tag --force _ribbon origin/master
    redraw!
endfunction

command! Ribbon     :call s:Ribbon()
command! RibbonSave :call s:RibbonSave()


