" vim: foldmethod=indent foldlevel=0

" simply fixing some highlighting I don't like like italic and such
fun! CedHighlightFix()
	" cursor >>>
	" more visible (no matter what the theme is)
	hi Cursor guifg=white guibg=hotpink
	" <<<

	hi SpecialKey guibg=NONE ctermbg=NONE
	hi NonText guibg=NONE ctermbg=NONE
	hi Comment gui=NONE
	"hi Identifier gui=NONE
	"hi StorageClass gui=NONE
	hi Folded guibg=NONE
	"hi String gui=NONE

	if g:colors_name=="materialtheme"
		" temp highlight fix
		hi Search gui=bold guibg=#80cbc4 guifg=#37474f
		hi LineNr guifg=#80cbc4 guibg=#37474f
		hi CursorLineNr guibg=#37474f
	endif
	if g:colors_name=="primary"
		hi String gui=NONE
		hi Character gui=NONE
		hi TypeDef gui=NONE
	endif
endfunction
nnoremap <leader>hf :call CedHighlightFix()<CR>

" Stopping the auto cleanup for now
"augroup HighlightFixGroup
"	au!
"	autocmd ColorScheme * call ced#HighlightFix()
"augroup END

" ======================================================================
" a little function to add separation lines for a line a comment on my code
" required: tcomment because the lines are commented automatically
function! ced#SepLine()
	" we duplicate the current line
	normal yyP
	" change the current line into = symbols
	normal ^v$r=
	" then duplicate the line below the text
	normal yyjp
	" lastly commenting
	normal V2kgc
endfunction

function! ced#SepLineSingle()
	" we duplicate the current line
	normal yyp
	" change the current line into = symbols + commenting
	normal ^v$r=gcc
endfunction

" ======================================================================
" Little matching that I use for Japanese Text
" (with a colorscheme like zazen)
fun! HighlightNonAscii()
	" I want to test 日本語 text!
	echom "日本語 highlighted"
	hi JapaneseStringHighlight guibg=#FDF6E3 guifg=#D33682
	match JapaneseStringHighlight "[^\x00-\x7F]"
endfunction
" [H]ighlight [J]apanese
nnoremap <leader>hj :call HighlightNonAscii()<CR>

" ======================================================================
" supposed to get a file cleaned of duplicates, but uniq is not a standard command so it does not work well
" in cygwin though, it should be ok
function! CleanDups()
	sort
	normal %!uniq
	g /^$/d
endfunction

" ======================================================================
" unload buffers with an ID higher that @param id
function! BufUnloadMoreThanId(id)
	bufdo if bufnr('%')>a:id | bd | endif
endfunction

" ======================================================================
" inpiration: http://vim.wikia.com/wiki/Capture_ex_command_output
function! ArgsToNewBuffer()
	redir l:arguments >
	silent execute "args"
	redir END
	silent put=l:arguments
	"let @"=substitute(@",' ', '\r', 'g')
	"normal p
endfunction

" ======================================================================
" look for functions in the current fille
function! FunctionsList()
	let ok=1
	if (&filetype == "php")
		vimgrep /\<function\>.*(/j %
	elseif (&filetype == "javascript")
		" This is a lazy regex but it'll do for now!
		" also used to count functions in azet-comment.vin
		vimgrep /^\s*function/j %
	else
		echo "File type ".&filetype." not yet supported"
		let ok=0
	endif
	" TODO adding other file type support
	" finally showing the results
	if (ok==1)
		cw
	endif
endfunction
nnoremap <leader>ff :call FunctionsList()<CR>

" ======================================================================
function! SearchForLine()
	normal ^"ly$
	normal /l<CR>
endfunction

nnoremap <leader>sl :call SearchForLine()<CR>

" ======================================================================
" smarty assigns
function! SmartyAssignVariable()
	normal ^lyE^"_D
	let l:txt = "$smarty->assign('".@"."', $".@".");"
	let @" = l:txt
	normal p
endfunction
nnoremap <leader>sav :call SmartyAssignVariable()<CR>

"======================================================================
" looks for a php function under the cursor
function! LookupPhpFunction()
	normal yiw
	let word=@"
	let url="http://php.net/manual-lookup.php?pattern=".word."&scope=quickref"
	echo "opening: ".url
	" NOTE: only supports Windows (for now)
	silent exec "!cmd /c start ".url
endfunction
nnoremap <leader>php :call LookupPhpFunction()<CR>

" from selection
function! GoogleTranslate()
	" content of visual selection automatically copied in * register
	let word=@*
	let url="https://translate.google.com/#ja/en/".word
	echo "opening: ".url
	" NOTE: only supports Windows (for now)
	"silent exec "!cmd /c open ".fnameescape(shellescape(url, 1))
	silent exec "!cmd /c open ".fnameescape(url)
endfunction
vnoremap <leader>gt :call GoogleTranslate()<CR>
" これはテストです

" ======================================================================
" Setting for different files types
" ======================================================================

function! ced#TagJumpDown()
	" saving previous search
	let l:sch = @/
	let l:line = search("<[a-z].*\>")
	" restore search
	let @/ = l:sch
	normal zz
endfunction

function! ced#TagJumpUp()
	" saving previous search
	let l:sch = @/
	let l:line = search("<[a-z].*\>", 'b')
	" restore search
	let @/ = l:sch
	normal zz
endfunction

function! ced#HtmlInit()
	nnoremap <buffer> <up> :call ced#TagJumpUp()<CR>
	nnoremap <buffer> <down> :call ced#TagJumpDown()<CR>
	" spaces in HTML
	inoremap <buffer> <S-SPACE> &nbsp;
	"<br> in HTML
	inoremap <buffer> <S-CR> <br>
endfunction

function! ced#FunctionJumpUp()
	" saving previous search
	let l:sch = @/
	let l:line = search("function", 'b')
	" restore search
	let @/ = l:sch
	normal zz
endfunction

function! ced#FunctionJumpDown()
	" saving previous search
	let l:sch = @/
	let l:line = search("function")
	" restore search
	let @/ = l:sch
	normal zz
endfunction

function! ced#PhpInit()
	nnoremap <buffer> <up> :call ced#FunctionJumpUp()<CR>
	nnoremap <buffer> <down> :call ced#FunctionJumpDown()<CR>
endfunction

augroup ftInit
	au!
	" mappings
	au BufRead *.tpl  setlocal filetype=html
	au BufRead *.inc  setlocal filetype=php
	au BufRead *.ctp  setlocal filetype=php

	" buffer options
	au FileType html,smarty call ced#HtmlInit()
	au FileType php call ced#PhpInit()
	"au FileType phtml setlocal autoindent nosmartindent
	au FileType javascript,css,html,smarty,clojure setlocal iskeyword+=-,@-@
	au FileType css setlocal omnifunc=csscomplete#CompleteCSS iskeyword+=#
	au FileType python,haskell setlocal tabstop=4 shiftwidth=4 expandtab
	au FileType php setlocal iskeyword-=-
	" included files are freaking slow in ruby!
	au FileType ruby setlocal complete-=i
augroup END

function! ced#DeleteCssBlock()
	set nohls
	normal va{Vd
endfunction

nnoremap <leader>dc :call ced#DeleteCssBlock()<CR>


" ======================================================================
" changing lightline colorscheme on the fly
" ======================================================================

" then calling the following function
function! CedLightlineUpdate(color_)
	let g:lightline.colorscheme = a:color_
	call lightline#init()
	call lightline#colorscheme()
	call lightline#update()
endfunction


" ======================================================================
" Display current scope in programms (php of javascript at best)
" simply echoes the closest line containing "function" above the current line
" ======================================================================
function! DisplayScope()
	" jump to previous function
	let line = search('\vfunction.{-}\(', 'bn')
	"echo line
	echo matchstr(getline(line), '\vfunction.{-}\(')
endfunction
nnoremap <leader>ds :call DisplayScope()<CR>
