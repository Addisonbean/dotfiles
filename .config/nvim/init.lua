-- TODO:

-- Fix lualine_theme.lua in git
--   Like be able to update it without affecting git's status/read values from the environment or something not tracked in git
-- Make a gitsubmodule for ~/.config/nvim to more easily update my config on various computers???
-- Toggle block comments
--   https://github.com/JoosepAlviste/nvim-ts-context-commentstring/blob/main/lua/ts_context_commentstring/integrations/vim_commentary.lua
-- Don't crash on missing or broken modules
-- Find new binding for emmet expansion things... (not `<c-y>`)
-- Make this file actually reload properly when sourcing the config. This maybe? https://stackoverflow.com/a/72504767
-- Use more lua in here
-- Fix `g.` to select the previously edited text

-- When reloading this file, reload all my modules in case they've changed (this doesn't seem to work anymore...)
for k, _ in ipairs({
	'util',
	'plugins',
	'settings',
	'mappings',
	'commands',
	'lsp',
	'treesitter',
	'autocommands',
	'custom',
}) do
	package.loaded[k] = nil
end

require('plugins')
require('settings')
require('mappings')
require('commands')
require('lsp')
require('treesitter')
require('autocommands')

pcall(require, 'custom')
