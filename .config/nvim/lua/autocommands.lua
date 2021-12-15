vim.cmd [[
augroup my_autocommands
    au!

    au BufRead,BufNewFile *.gmi,*.gemini setlocal filetype=gemini

    au BufRead ~/.config/nvim/init.lua setlocal path+=~/.config/nvim,~/.config/nvim/lua

    " Show line numbers in the quick fix window
    au FileType qf setlocal number

    " Alway unload buffers containing neovim config rather than hide
    " Only matters when `hidden` is set
    au BufRead,BufNewFile ~/.config/nvim/* setlocal bufhidden=unload

    au FileType html,css,vue,less setlocal iskeyword+=-
    au FileType less setlocal iskeyword+=@
    
    au FileType vimwiki,text,markdown setlocal linebreak expandtab shiftwidth=2 tabstop=2
    
    au FileType haskell setlocal expandtab tabstop=2 shiftwidth=2
augroup END
]]
