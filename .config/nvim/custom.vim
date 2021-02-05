let s:xcolorscheme = system('xrdb -query | grep "vim.colorscheme" | cut -f 2')
if !empty(s:xcolorscheme)
	execute "color " . s:xcolorscheme
endif

let s:alpha = system('xrdb -query | grep "vim.transparent-bg" | cut -f 2')
if s:alpha ==? "true\n"
	hi clear SignColumn
	hi LineNr guifg=grey ctermfg=grey
	hi LineNr guibg=NONE
	hi Normal guibg=NONE ctermbg=NONE
	hi StatusLine guibg=NONE cterm=NONE
endif
