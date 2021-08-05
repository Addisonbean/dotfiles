-- TODO:

-- Don't crash on missing modules
-- Fix <c-p> in non git directories
-- Fix lualine_theme.lua in git (like be able to update it without affecting git's status)
-- Make a gitsubmodule for ~/.config/nvim to more easily update my config on various computers???
-- review what options should/shouldn't be buffer/window local
-- Get xresources data via. lua (if available)
-- Toggle block comments
--   https://github.com/JoosepAlviste/nvim-ts-context-commentstring/blob/main/lua/ts_context_commentstring/integrations/vim_commentary.lua
-- Use packers's `config` to configure plugins
-- Put stuff like `Map` into a util module and import to fix lsp errors
-- Have the mappings (and other stuff) reload when reloading config

-- From old config:
--   [ ] auto commands

-- TODO: is this needed? Does neovim do this for me?
math.randomseed(os.time())

-- Adapted from here: https://oroques.dev/notes/neovim-init/#mappings
function Map(mode, binding, action, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, binding, action, options)
end

-- Taken from here: https://stackoverflow.com/a/15434737/1525759
local function isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

require('plugins')
require('settings')
require('plugin_setup')
require('mappings')
require('commands')
require('lsp')
require('treesitter')
require('autocommands')

if isModuleAvailable('custom') then require('custom') end
