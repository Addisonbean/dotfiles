vim.cmd [[
let xcolorscheme = system('xrdb -query | grep "vim.colorscheme" | cut -f 2')
if !empty(xcolorscheme)
    execute "color " . xcolorscheme
else
    color ayu
endif

let alpha = system('xrdb -query | grep "vim.transparent-bg" | cut -f 2')
if alpha ==? "true\n"
    hi clear SignColumn
    hi LineNr guifg=grey ctermfg=grey
    hi LineNr guibg=NONE
    hi Normal guibg=NONE ctermbg=NONE
    hi StatusLine guibg=NONE cterm=NONE
endif
]]

vim.cmd 'hi EndOfBuffer guibg=NONE guifg=NONE cterm=NONE'
