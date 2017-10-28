function! MarkdownLevel()
    "if getline(v:lnum) =~ '^# .*$'
    "    return ">1"
    "endif
    "if getline(v:lnum) =~ '^## .*$'
    "    return ">2"
    "endif
    "if getline(v:lnum) =~ '^### .*$'
    "    return ">3"
    "endif
    "if getline(v:lnum) =~ '^#### .*$'
    "    return ">4"
    "endif
    "if getline(v:lnum) =~ '^##### .*$'
    "    return ">5"
    "endif
    "if getline(v:lnum) =~ '^###### .*$'
    "    return ">6"
    "endif
    " I want to see all titles folded as one block
    if getline(v:lnum) =~ '^#'
    	return ">1"
    endif
    return "=" 
endfunction
au BufRead *.md setlocal foldexpr=MarkdownLevel()
au BufRead *.md setlocal foldmethod=expr
au BufRead *.md setlocal foldlevel=0
