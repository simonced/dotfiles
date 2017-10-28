" ======================================================================
" Custom lightline colors
" by simonced (starting point from landscape lightline colorscheme)
" ======================================================================

let s:blue =  '#3498DB'
let s:dark_blue = '#217DBB'
let s:dark = '#2C3E50'
let s:green = '#18BC9C'
let s:grey = '#95A5A6'
let s:dark_grey = '#798D8F'
let s:light_grey = '#ECF0F1'
let s:yellow = '#F39C12'
let s:red = '#E74C3C'

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [s:blue, '#ffffff', 21, 231, 'bold' ], [ '#ffffff', s:blue, 231, 21 ], [ s:light_grey, s:dark, 245, 236 ] ]
let s:p.normal.right = [ [ '#ffffff', s:dark_grey, 236, 252 ], [ '#ffffff', s:grey, 236, 245 ], [ '#ffffff', s:light_grey, 250, 240 ] ]
let s:p.normal.middle = [ [ s:dark_blue, s:light_grey, 245, 236 ] ]
let s:p.normal.error = [ [ '#d0d0d0', '#ff0000', 252, 196 ] ]
let s:p.normal.warning = [ [ '#262626', '#ffff00', 235, 226 ] ]

let s:p.insert.left =  [ [s:green, '#ffffff', 22, 231, 'bold' ], [ '#ffffff', s:green, 231, 22 ], [ '#ffffff', s:dark_blue, 231, 22 ] ]
let s:p.insert.middle =  [ ['#ffffff', s:blue, 22, 231 ] ]

let s:p.replace.left = [ [ s:red, '#ffffff', 124, 231, 'bold' ], [ '#ffffff', s:red, 231, 124 ], [ '#ffffff', s:dark_blue, 231, 22 ] ]

let s:p.visual.left = [ [ s:yellow, '#ffffff', 57, 231, 'bold' ], [ '#ffffff', s:yellow, 231, 57 ], [ '#ffffff', s:dark_grey, 231, 57 ] ]

let s:p.inactive.right = [ [ '#ffffff', s:dark, 233, 241 ], [ '#ffffff', s:dark, 233, 237 ], [ '#ffffff', s:dark, 233, 235 ] ]
let s:p.inactive.left = s:p.inactive.right[1:]
let s:p.inactive.middle = [ [ '#ffffff', s:dark, 236, 233 ] ]

" I don't use those...
let s:p.tabline.left = [ [ '#d0d0d0', '#666666', 252, 242 ] ]
let s:p.tabline.tabsel = [ [ '#dadada', '#121212', 253, 233 ] ]
let s:p.tabline.middle = [ [ '#8a8a8a', '#3a3a3a', 245, 237 ] ]
let s:p.tabline.right = [ [ '#d0d0d0', '#666666', 252, 242 ] ]

" scheme name
let g:lightline#colorscheme#ced#palette = s:p
