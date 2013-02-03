" ribbon.vim - Browse the latest git repo changes
" Maintainer:  Eric Johnson <http://kablamo.org>
" Version:     0.01

function! s:Ribbon()
    new
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
    noremap <buffer> <silent> q :quit<cr>

    let l:cmd = '0read ! git log --pretty=format:''\%an (\%cr) \%p:\%h\%n\%s'' --name-only --no-merges --reverse --topo-order _ribbon..origin/master'
    execute l:cmd
    normal 1G
endfunction

function! s:RibbonSave()
  silent !git tag --force _ribbon origin/master
  redraw!
endfunction

command! Ribbon     :call s:Ribbon()
command! RibbonSave :call s:RibbonSave()


