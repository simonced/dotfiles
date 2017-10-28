" vim: foldmethod=indent foldlevel=0

if exists("g:comment_author")==0
	" this variable can be personalized in vimrc to be used on different machines
	let g:comment_author="[set g:comment_author in your vimrc]"
endif

" ======================================================================
function! CommentFunction(line_)
	" wanted to try to auto-indet the newly added comment block
	" but I need more time to figure that out
	"normal ^
	"let mycolumn=col('.')
	"echo mycolumn

	if !empty(a:line_)
		"echo a:1
		let l:line = a:line_
	else
		" first trying to get the function name
		let l:line = "TODO"
		"normal ^wyt(
		"let l:line = @"
		"let @"=""
	endif

	" working with the function arguments
	normal ^f(yi(O
	let l:comment = "/**\n * ".l:line."\n *\n * TODO CODE\n *\n * @author ".g:comment_author."\n"
	if !empty(@")
		" tweaking arguments types if found
		let l:args = @"
		if l:args =~ "ERROR"
			let l:args = substitute(@", '\(&\?\)\$ERROR', 'array \1$ERROR', '')
		endif
		let l:args = substitute(l:args, ', ', ',', 'g')
		let l:params = " * @param TODO ".substitute(l:args, ",", "\n * @param TODO ", "g")
		let l:comment .= l:params . "\n"
	endif
	let l:comment .= " */"
	silent put=l:comment
	" we delete the blank line inserted before or comment block
	" and jump to the next TODO
	normal {dd/TODO
endfunction

" ======================================================================
func! CommentFunctionWithLine()
	let @"=""
	-1
	normal dd
	let @" = substitute(@", '\n', '', '')
	"echo "My content empty?:".empty(@")
	"return 0
	if !empty(@")
		let l:text = substitute(@", "^\\s*\/\/\\s*", "", "")
		call CommentFunction(l:text)
	else
		call CommentFunction("TODO")
	endif
endfunc

" [F]unction [Append] existing comment
nnoremap <leader>fc :call CommentFunctionWithLine()<CR>
" I screwed up a bit the part above, I'll finish my task with my file
"nnoremap <leader>fc :call CommentFunction("")<CR>

" ======================================================================
fun! InsertTabForCommentBlock()
	" cursor has to be anywhere in the block
	normal! V?\/\*o/\*\/
	exec "normal \<C-q>0I\<tab>\<esc>"
endfunction
" [b]lock [i]ndent
nnoremap <leader>bi :call InsertTabForCommentBlock()<CR>

" ======================================================================
func! SearchFunctionInFiles()
	" yank line and place a mark to return to that file
	normal ^"ayf)mA

	let l:extensions = "*"
	if (&filetype == "php")
		let l:extensions = "{php,inc}"
	endi
	if (&filetype == "javascript")
		let l:extensions = "{js}"
	endif

	"echo &filetype
	let l:command = "vimgrep /\\*\\/\\n.*".@a."/ *.".l:extensions."\<CR>"
	"echo l:command
	execute l:command
endfunc

nnoremap <leader>fs :call SearchFunctionInFiles()<CR>

func! CopyCommentToAfile()
	normal V{jy'AP
endfunc

nnoremap <leader>fr :call CopyCommentToAfile()<CR>

" ======================================================================
" useful mapping that surrounds a word with {
nnoremap <leader>st i{<esc>ea}<esc>

" ======================================================================
func! FunctionsCount()
	let l:funcCount = 0
	" pattern also used for counting javascript functions in my ced.vim plugin
	let l:pattern = "^\s*function"
	" back to the top of the file
	normal ma
	0

	" simple serach pattern, good for most cases
	let l:found = search(l:pattern)

	while l:found > 0
		let l:group = synIDattr(synID(line("."),col("."),1),"name")
		if l:group =~ "Comment"
		else
			let l:funcCount = l:funcCount + 1
		endif

		let l:found = search(l:pattern)
	endwhile

	" restore cursor position
	normal `a

	echo "Functions found:".l:funcCount

	" synIDattr(synID(line("."),col("."),1),"name")
endfunction

