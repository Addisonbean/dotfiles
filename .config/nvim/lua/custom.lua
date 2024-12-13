vim.cmd 'hi EndOfBuffer guibg=NONE guifg=NONE cterm=NONE'

-- TODO: fail gracefully

local fd = io.popen('xrdb -q')
local res = fd:read('*a')
fd:close()

local xres = {}
for k, v in string.gmatch(res, "([^%s:]+):%s*([^\n]+)") do
	xres[k] = v
end

local function clearBackground()
	vim.cmd [[
		hi clear SignColumn
		hi LineNr guifg=grey ctermfg=grey
		hi LineNr guibg=NONE
		hi Normal guibg=NONE ctermbg=NONE
		hi StatusLine guibg=NONE cterm=NONE
	]]
end

local alpha = xres['vim.transparent-bg'] == 'true'
if alpha then
	vim.api.nvim_create_augroup('clear-bg', { clear = true })
	vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = '*',
	group = 'clear-bg',
	callback = clearBackground,
	})
end

-- TODO: only apply when using a theme that wants this...
-- Maybe even have a vim startup script to source after the init.lua for each theme...
vim.api.nvim_create_augroup('colorscheme', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = 'vimspectr330-light',
	group = 'colorscheme',
	command = 'hi Normal guifg=#dddddd ctermfg=white | hi CursorLine guifg=#7d5e6d',
})
vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = 'typewriter-night',
	group = 'colorscheme',
	command = 'hi clear CursorLine | hi CursorLine gui=NONE guibg=#333333',
})

local colorscheme = xres['vim.colorscheme']

if colorscheme == 'xresources' then
	require('base16-colorscheme').setup({
		base00 = xres['vim.base0'],
		base01 = xres['vim.base1'],
		base02 = xres['vim.base2'],
		base03 = xres['vim.base3'],
		base04 = xres['vim.base4'],
		base05 = xres['vim.base5'],
		base06 = xres['vim.base6'],
		base07 = xres['vim.base7'],
		base08 = xres['vim.base8'],
		base09 = xres['vim.base9'],
		base0A = xres['vim.baseA'],
		base0B = xres['vim.baseB'],
		base0C = xres['vim.baseC'],
		base0D = xres['vim.baseD'],
		base0E = xres['vim.baseE'],
		base0F = xres['vim.baseF'],
	})
	if xres['vim.transparent-bg'] == 'true' then
		clearBackground()
	end
else
	vim.cmd('color ' .. colorscheme)
end

local text_color = xres['vim.text-fg']
if text_color ~= 'default' then
	vim.cmd('hi Normal guifg=' .. text_color)
end
