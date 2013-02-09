" ribbon.vim - Browse the latest git repo changes
" Maintainer:  Eric Johnson <http://kablamo.org>
" Version:     0.01
"
" TODO: 
"  - smoother diff action
"  - exit if Fugitive is not found

let g:RibbonBufname='Ribbon'
let g:RibbonHeight=10

let s:bufnr=0

function! s:Ribbon()
    let l:cmd = 'edit ' . g:RibbonBufname
    execute l:cmd

    " setup new Ribbon buffer
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
    if exists('+concealcursor')
      setlocal concealcursor=nc conceallevel=2
    endif

    " load git output into the Ribbon buffer
    let l:cmd = 'silent 0read ! git log --pretty=format:''\%an (\%cr) \%p:\%h\%n\%s'' --stat --no-merges --reverse --topo-order _ribbon..origin/master'
    execute l:cmd
    normal 1G

    let s:bufnr = bufnr(g:RibbonBufname)
endfunction

function! ribbon#diff()
    " get filename to diff
    let l:filename = getline(".")
    
    " return if file does not exist
    let l:cwd = getcwd()
    Gcd
    let l:repo = getcwd()
    if !filereadable(l:repo . '/' . l:filename)
        execute 'cd ' . l:cwd
        return
    endif

    " parse git output in Ribbon buffer to get revisions
    let l:oldLineNr = line(".")
    let l:lineNr    = search(') \(\w\+:\w\+\)$', 'b')
    let l:line      = getline(l:lineNr)
    let l:revisions = substitute(l:line, '.*) \(\w\+:\w\+\)$', '\=submatch(1)', "")
    let l:rev       = split(l:revisions, ':')
    execute 'normal ' . l:oldLineNr . 'G'

    " show rev0:file
    execute 'Git! show ' . l:rev[0] . ':' . l:filename
    let l:bufnr0 = bufnr("")

    " show rev1:file
    execute 'rightbelow vsplit | Git! show ' . l:rev[1] . ':' . l:filename
    let l:bufnr1 = bufnr("")
    let l:cmd='nnoremap <buffer> <silent> q :' . l:bufnr0 . 'bunload<cr>:' . l:bufnr1 . 'bunload<cr>'

    " show diff
    diffthis
    wincmd p
    execute l:cmd
    diffthis
    wincmd p
    execute l:cmd

    " return user to original wd
    execute 'cd ' . l:cwd
endfunction

function! s:RibbonSave()
    silent !git tag --force _ribbon origin/master
    redraw!
endfunction

command! Ribbon     :call s:Ribbon()
command! RibbonSave :call s:RibbonSave()


