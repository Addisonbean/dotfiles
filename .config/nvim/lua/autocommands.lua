vim.cmd [[
augroup my_autocommands
    au!
    au BufRead ~/.config/nvim/init.lua setlocal path+=~/.config/nvim,~/.config/nvim/lua

    " Show line numbers in the quick fix window
    au FileType qf setlocal number

    " Alway unload buffers containing neovim config rather than hide
    " Only matters when `hidden` is set
    au BufRead,BufNewFile ~/.config/nvim/* setlocal bufhidden=unload
augroup END
]]
