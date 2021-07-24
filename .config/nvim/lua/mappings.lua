-- This doesn't include mappings for plugins.
-- To see where a mapping is created, use `:map <mapping>`

-- Opens something like {} up to a multiline kinda thing then puts the cursor in the middle
Map('n', '<c-l>', 'i<cr><cr><esc>k"_S', { silent = true })
Map('i', '<c-l>', '<cr><cr><esc>k"_S', { silent = true })

-- Toggle `spell`
Map('n', '<c-s><c-s>', '<cmd>set spell!<cr>', { silent = true })
Map('i', '<c-s><c-s>', '<cmd>set spell!<cr>', { silent = true })

-- TODO: these are broken

-- Open config
Map('n', '<leader>ev', ':e $MYVIMRC<cr>', { silent = true })

-- Reload config
Map('n', '<leader>rv', ':source $MYVIMRC <bar> doautocmd BufRead<cr>')

-- {{{ Copy/paste/cut stuff

-- Use `<leader>s` to copy/cut/paste from the system clipboard
Map('v', '<leader>sy', '"+y')
Map('v', '<leader>sd', '"+d')
Map('n', '<leader>sY', '"+Y')
Map('n', '<leader>sp', '"+p')
Map('n', '<leader>sP', '"+P')

-- Stop s, x, d, and c from copying
Map('n', 's', '"_s')
Map('n', 'S', '"_S')
Map('n', 'd', '"_d')
Map('n', 'D', '"_D')
Map('n', 'c', '"_c')
Map('n', 'C', '"_C')
Map('n', 'x', '"_x')
Map('n', 'X', '"_X')

Map('v', 's', '"_s')
Map('v', 'S', '"_S')
Map('v', 'd', '"_d')
Map('v', 'D', '"_D')
Map('v', 'c', '"_c')
Map('v', 'C', '"_C')
Map('v', 'x', '"_x')
Map('v', 'X', '"_X')

-- Prefix s, x, d, and c with <leader> to copy
Map('n', '<leader>s', 's')
Map('n', '<leader>S', 'S')
Map('n', '<leader>d', 'd')
Map('n', '<leader>D', 'D')
Map('n', '<leader>c', 'c')
Map('n', '<leader>C', 'C')
Map('n', '<leader>x', 'x')
Map('n', '<leader>X', 'X')

Map('v', '<leader>s', 's')
Map('v', '<leader>S', 'S')
Map('v', '<leader>d', 'd')
Map('v', '<leader>D', 'D')
Map('v', '<leader>c', 'c')
Map('v', '<leader>C', 'C')
Map('v', '<leader>x', 'x')
Map('v', '<leader>X', 'X')

-- }}}

-- TODO: is there a more general way to do this?
-- Remap <C-a> since that's my tmux prefix and <C-c> is useless by default
Map('n', '<c-c>', '<c-c>')
Map('v', '<c-c>', '<c-c>')
Map('v', 'g<c-c>', 'g<c-a>')

-- Unhighlight all text
Map('n', '<c-h>', '<cmd>noh<cr>')
Map('i', '<c-h>', '<cmd>noh<cr>')

-- Toggle line numbers
Map('n', '<c-q>', '<cmd>set number!<cr>')

-- Use [<space> and ]<space> to add a new line above/below the current line
-- (Thanks to https://vi.stackexchange.com/a/3891/8749 for extracting this
-- from the tpope/vim-unimpaired plugin)
Map('n', '[<space>', [[<cmd>put!=repeat([''],v:count)<bar>']+1<cr>]])
Map('n', ']<space>', [[<cmd>put =repeat([''],v:count)<bar>'[-1<cr>]])

-- Maybe just type `:norm @q` out normally when I need to do this?
-- xnoremap <silent> @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
-- function! ExecuteMacroOverVisualRange()
-- 	echo "@".getcmdline()
-- 	execute ":'<,'>normal @".nr2char(getchar())
-- endfunction

-- Use <space> to toggle a fold
Map('n', '<space>', 'za')

-- Add a markdown/reST heading
Map('n', '<leader>h', '^v$hyo<esc>p==^v$hr')

-- TODO: change this, but also use `map!` or maybe `abbr`
-- Insert the current date (year -> month -> date so it sorts well)
Map('!', '<c-d><c-d>', [[<c-r>=strftime('%Y-%m-%d')<cr>]])

-- vim:foldmethod=marker:foldlevel=0
