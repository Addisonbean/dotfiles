-- TODO:

-- Make a gitsubmodule for ~/.config/nvim to more easily update my config on various computers???
-- Toggle block comments
--   https://github.com/JoosepAlviste/nvim-ts-context-commentstring/blob/main/lua/ts_context_commentstring/integrations/vim_commentary.lua
-- Don't crash on missing or broken modules
-- Find new binding for emmet expansion things... (not `<c-y>`)
-- Make this file actually reload properly when sourcing the config. This maybe? https://stackoverflow.com/a/72504767
-- Use more lua in here (done?)
-- Fix `g.` to select the previously edited text

require('plugins')
require('settings')
require('mappings')
require('commands')
require('lsp')
require('treesitter')
require('autocommands')

pcall(require, 'custom')
