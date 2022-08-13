vim.cmd 'hi EndOfBuffer guibg=NONE guifg=NONE cterm=NONE'

-- for result in string.gmatch("vim: 123\nvim2: 1234\n", "[^%s:]+:%s+([^\n]+)") do print(result) end

-- TODO: fail gracefully

local fd = io.popen('xrdb -q')
local res = fd:read('*a')
fd:close()

local xres = {}
for k, v in string.gmatch(res, "([^%s:]+):%s+([^\n]+)") do
    xres[k] = v
end

local alpha = xres['vim.transparent-bg'] == 'true'
if alpha then
    vim.cmd [[
	augroup clear_bg
	    au!
	    au ColorScheme * hi clear SignColumn
	    au ColorScheme * hi LineNr guifg=grey ctermfg=grey
	    au ColorScheme * hi LineNr guibg=NONE
	    au ColorScheme * hi Normal guibg=NONE ctermbg=NONE
	    au ColorScheme * hi StatusLine guibg=NONE cterm=NONE
	augroup END
    ]]
end

-- TODO: only apply when using a theme that wants this...
-- Maybe even have a vim startup script to source after the init.lua for each theme...
vim.cmd [[
    augroup colorscheme
	au!
	au ColorScheme vimspectr330-light hi Normal guifg=grey ctermfg=grey
	au ColorScheme typewriter-night hi clear CursorLine
	au ColorScheme typewriter-night hi CursorLine gui=NONE guibg=#333333
    augroup END
]]

vim.cmd('color ' .. xres['vim.colorscheme'])
