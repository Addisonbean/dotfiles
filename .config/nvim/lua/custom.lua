vim.cmd [[
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

-- for result in string.gmatch("vim: 123\nvim2: 1234\n", "[^%s:]+:%s+([^\n]+)") do print(result) end

-- TODO: fail gracefully

local fd = io.popen('xrdb -q')
local res = fd:read('*a')
fd:close()

local xres = {}
for k, v in string.gmatch(res, "([^%s:]+):%s+([^\n]+)") do
    xres[k] = v
end

vim.cmd('color ' .. xres['vim.colorscheme'])

local alpha = xres['vim.transparent-bg'] == 'true'
if alpha then
    -- Whyyyyyy doesn't this work...
    vim.cmd [[
	hi clear SignColumn
	hi LineNr guifg=grey ctermfg=grey
	hi LineNr guibg=NONE
	hi Normal guibg=NONE ctermbg=NONE
	hi StatusLine guibg=NONE cterm=NONE
    ]]
end
