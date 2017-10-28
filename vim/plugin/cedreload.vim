" simple function, that can work on windows as well,
" wget is not hard to find and install
function! NodeReady()
    " find a better way
    let @_=system("wget http://localhost:8088/ready --quiet")
    let @_=system("rm ready*")
    "silent let @_=system("wget http://localhost:8088/ready --quiet")
endfunction

" mapping proposal
nnoremap <leader>nn :call NodeReady()<CR>
