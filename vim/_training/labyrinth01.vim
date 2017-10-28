set nocompatible
set hls

" for dev only
nnoremap <silent> rr :so labyrinth01.vim<CR>:e<CR>

noremap <up> :call KeyNope()<CR>
noremap <down> :call KeyNope()<CR>
noremap <left> :call KeyNope()<CR>
noremap <right> :call KeyNope()<CR>

function! KeyNope()
	echom "No arrow key allowed!"
	echohl
endfunction

function! Reset()
	set readonly
	normal gg
	let @/="XEX"
	normal 6GfS
endfunction

" Bootstrap
au! BufRead labyrinth01.txt
au BufRead labyrinth01.txt call Reset()


