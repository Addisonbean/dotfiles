-- TODO:

-- Fix lualine_theme.lua in git
--   Like be able to update it without affecting git's status/read values from the environment or something not tracked in git
-- Make a gitsubmodule for ~/.config/nvim to more easily update my config on various computers???
-- Use packers's `config` to configure plugins
-- Audit plugin_setup and remove stuff for plugins I don't use anymore...
-- Review what options should/shouldn't be buffer/window local
-- Toggle block comments
--   https://github.com/JoosepAlviste/nvim-ts-context-commentstring/blob/main/lua/ts_context_commentstring/integrations/vim_commentary.lua
-- Don't crash on missing or broken modules
-- Find new binding for emmet expansion things... (not `<c-y>`)
-- Check this out https://stackoverflow.com/questions/2440149/override-colorscheme

-- When reloading this file, reload all my modules in case they've changed
for k, _ in ipairs({
	'util',
	'plugins',
	'settings',
	'plugin_setup',
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
require('plugin_setup')
require('mappings')
require('commands')
require('lsp')
require('treesitter')
require('autocommands')

pcall(require, 'custom')
