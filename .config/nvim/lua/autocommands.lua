vim.cmd [[
augroup my_autocommands
    au!
    au BufRead ~/.config/nvim/init.lua setlocal path+=~/.config/nvim,~/.config/nvim/lua
    au FileType qf setlocal number
augroup END
]]
