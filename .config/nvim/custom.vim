" Remove the middle part of the status line that's empty
let s:new_theme = g:lightline#colorscheme#ayu_dark#palette

let s:new_theme.normal.middle = [[ '1', '1', '1', '1' ]]
let s:new_theme.inactive.middle = [[ '1', '1', '1', '1' ]]
" let s:new_theme.normal.middle = [[ 'NONE', 'NONE', 'NONE', 'NONE' ]]
" let s:new_theme.inactive.middle = [[ 'NONE', 'NONE', 'NONE', 'NONE' ]]

" let s:new_theme. = system('xrdb -query | grep "vim.colorscheme" | cut -f 2')
let g:lightline#colorscheme#ayu_dark#palette = s:new_theme

let s:xcolorscheme = system('xrdb -query | grep "vim.colorscheme" | cut -f 2')
if !empty(s:xcolorscheme)
	execute "color " . s:xcolorscheme
else
	color ayu
endif

let s:alpha = system('xrdb -query | grep "vim.transparent-bg" | cut -f 2')
if s:alpha ==? "true\n"
	hi clear SignColumn
	hi LineNr guifg=grey ctermfg=grey
	hi LineNr guibg=NONE
	hi Normal guibg=NONE ctermbg=NONE
	hi StatusLine guibg=NONE cterm=NONE
endif
