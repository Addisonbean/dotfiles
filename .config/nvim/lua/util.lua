-- Adapted from here: https://oroques.dev/notes/neovim-init/#mappings
local function map(mode, binding, action, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, binding, action, options)
end

return {
  map = map,
}
