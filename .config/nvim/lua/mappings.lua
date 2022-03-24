local map = require('util').map

-- This doesn't include mappings for plugins.
-- To see where a mapping is created, use `:map <mapping>`

--  Use `jk` to enter normal mode
-- map('i', 'jk', '<esc>')
-- map('v', 'jk', '<esc>')

-- Opens something like {} up to a multiline kinda thing then puts the cursor in the middle
map('n', '<c-l>', 'i<cr><cr><esc>k"_S', { silent = true })
map('i', '<c-l>', '<cr><cr><esc>k"_S', { silent = true })

-- Toggle `spell`
map('n', '<c-s><c-s>', '<cmd>set spell!<cr>')
map('i', '<c-s><c-s>', '<cmd>set spell!<cr>')

-- Open config
map('n', '<leader>ev', '<cmd>e $MYVIMRC<cr>')

-- TODO: this doesn't actually reload the lua...
-- Reload config
map('n', '<leader>rv', '<cmd>source $MYVIMRC <bar> doautocmd BufRead<cr>')

-- {{{ Copy/paste/cut stuff

-- Use `<leader>s` to copy/cut/paste from the system clipboard
map('v', '<leader>sy', '"+y')
map('v', '<leader>sd', '"+d')
map('n', '<leader>sY', '"+Y')
map('n', '<leader>sp', '"+p')
map('n', '<leader>sP', '"+P')

-- Stop s, x, d, and c from copying
map('n', 's', '"_s')
map('n', 'S', '"_S')
map('n', 'd', '"_d')
map('n', 'D', '"_D')
map('n', 'c', '"_c')
map('n', 'C', '"_C')
map('n', 'x', '"_x')
map('n', 'X', '"_X')

map('v', 's', '"_s')
map('v', 'S', '"_S')
map('v', 'd', '"_d')
map('v', 'D', '"_D')
map('v', 'c', '"_c')
map('v', 'C', '"_C')
map('v', 'x', '"_x')
map('v', 'X', '"_X')

-- Prefix s, x, d, and c with <leader> to copy
map('n', '<leader>s', 's')
map('n', '<leader>S', 'S')
map('n', '<leader>d', 'd')
map('n', '<leader>D', 'D')
map('n', '<leader>c', 'c')
map('n', '<leader>C', 'C')
map('n', '<leader>x', 'x')
map('n', '<leader>X', 'X')

map('v', '<leader>s', 's')
map('v', '<leader>S', 'S')
map('v', '<leader>d', 'd')
map('v', '<leader>D', 'D')
map('v', '<leader>c', 'c')
map('v', '<leader>C', 'C')
map('v', '<leader>x', 'x')
map('v', '<leader>X', 'X')

-- }}}

-- TODO: is there a more general way to do this?
-- Remap <C-a> since that's my tmux prefix and <C-c> is useless by default
map('n', '<c-c>', '<c-a>')
map('v', '<c-c>', '<c-a>')
map('v', 'g<c-c>', 'g<c-a>')

-- Unhighlight all text and clear the command line
map('n', '<c-h>', '<cmd>noh <bar> echo ""<cr>')
map('i', '<c-h>', '<cmd>noh <bar> echo ""<cr>')

-- Toggle line numbers
map('n', '<c-q>', '<cmd>set number!<cr>')

-- Use [<space> and ]<space> to add a new line above/below the current line
-- (Thanks to https://vi.stackexchange.com/a/3891/8749 for extracting this
-- from the tpope/vim-unimpaired plugin)
map('n', '[<space>', [[<cmd>put!=repeat([''],v:count)<bar>']+1<cr>]])
map('n', ']<space>', [[<cmd>put =repeat([''],v:count)<bar>'[-1<cr>]])

-- Maybe just type `:norm @q` out normally when I need to do this?
-- xnoremap <silent> @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
-- function! ExecuteMacroOverVisualRange()
-- 	echo "@".getcmdline()
-- 	execute ":'<,'>normal @".nr2char(getchar())
-- endfunction

-- Use <space> to toggle a fold
map('n', '<space>', 'za')

-- Add a markdown/reST heading
map('n', '<leader>h', '^v$hyo<esc>p==^v$hr')

-- Select the previously pasted or edited text
map('n', 'gp', '`[v`]')

-- TODO: maybe make this a text-object so I can do something
-- like `yil` to "yank inner line"
map('n', '<leader>vl', '^v$h')

-- Open netrw for the directory of the current file
map('n', '-', ':e %:h<cr>', { silent = true })

-- Insert the current date (year -> month -> date so it sorts well)
-- `!` mode is insert + command mode
map('!', '<c-\\><c-d>', [[<c-r>=strftime('%Y-%m-%d')<cr>]], { silent = true })

-- Make `<c-r>` start a new undo block
map('i', '<c-r>', '<c-g>u<c-r>')

-- neovim 0.6.0 remaps this
vim.cmd 'unmap Y'

map('i', '<c-r>', '<c-g>u<c-r>')
map('i', '.', '<c-g>u.')
map('i', '!', '<c-g>u!')
map('i', '?', '<c-g>u?')
map('i', '<cr>', '<c-g>u<cr>')

-- vim:foldmethod=marker:foldlevel=0
