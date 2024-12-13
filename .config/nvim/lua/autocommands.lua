-- This function is designed to fix `zM` for Obsidian files.
---
-- When viewing a file with the Obsidian `--- ... ---` file header,
-- the line right before the second `---` is incorrectly interpreted
-- as a markdown heading, when it's actually just a part of the
-- Obsidian header containing file metadata/info.
--
-- It does the following:
--   - Closes all folds
--   - Opens the incorrect fold
--   - Restores the cursor position, just as `zM` normally does
local function foldAllAndOpenIncorrectObsidianFold()
	local firstLine = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
	if firstLine == '---' then
		local pos = vim.api.nvim_win_get_cursor(0)
		-- Note: zO is needed here instead of zo because, for some reason, there seems to be two folds in one spot here...
		vim.cmd('normal! zMggzjzO')
		vim.api.nvim_win_set_cursor(0, pos)
	end
end

-- Filetype detection

vim.api.nvim_create_augroup('detect-filetypes', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = { '*.gmi', '*.gemini' },
	command = 'setlocal filetype=gemini',
	group = 'detect-filetypes',
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = '*.rasi',
	command = 'setlocal filetype=rasi',
	group = 'detect-filetypes',
})

-- Filetype specific settings and mappings

vim.api.nvim_create_augroup('filetype-autocommands', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'markdown',
	callback = function()
		vim.keymap.set('n', 'zM', foldAllAndOpenIncorrectObsidianFold, { buffer = 0 })
	end,
	group = 'filetype-autocommands',
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'qf',
	callback = function()
		vim.bo.number = true
	end,
	group = 'filetype-autocommands',
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'html,css,vue,less',
	callback = function()
		vim.bo.iskeyword:append('-')
	end,
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'less',
	callback = function()
		vim.bo.iskeyword:append('@')
	end,
	group = 'filetype-autocommands',
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'vimwiki', 'text', 'markdown' },
	callback = function()
		vim.wo.linebreak = true
		vim.bo.expandtab = true
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
	end,
	group = 'filetype-autocommands',
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'vimwiki', 'text', 'markdown', 'gemini' },
	command = 'nmap <buffer> K <Plug>(victionary#define_under_cursor)',
	group = 'filetype-autocommands',
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'haskell',
	callback = function()
		vim.bo.expandtab = true
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
	end,
	group = 'filetype-autocommands',
})
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'xresources', 'xdefaults' },
	callback = function() vim.bo.commentstring = '! %s' end,
	group = 'filetype-autocommands',
})

-- File/location specific mappings

vim.api.nvim_create_augroup('filepath-based', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = vim.fn.expand('~/.config/nvim/') .. '*',
	command = 'setlocal path+=~/.config/nvim,~/.config/nvim/lua',
	-- The lua for this isn't working... It doesn't recognize `append`
	-- callback = function() vim.bo.path:append({ '~/.config/nvim', '~/.config/nvim/lua' }) end,
	group = 'filepath-based',
})
