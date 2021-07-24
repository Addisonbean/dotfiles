-- TODO:

-- review what options should/shouldn't be buffer/window local
-- Better copy/paste mappings (visual too)
-- Use `<cmd>` instead of `:` or `<c-o>:` for mappings
-- Make a util module for functions like `map` and stuff?
-- Get xresources data via. lua (if available)
-- Toggle block comments
-- Fix <c-p> in non git directories

-- From old config:
-- - [ ] Fix \rv and \ev mappings
-- - stuff in ~/.config/nvim/custom.vim
--   - [ ] lightline thing... (lualine)
--   - [ ] set lightline theme

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

if isModuleAvailable('custom') then require('custom') end
