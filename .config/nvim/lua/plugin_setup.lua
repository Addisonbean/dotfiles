-- This file includes plugin settings and plugin mappings

-- tomtom/tcomment_vim {{{

-- Comment/uncomment the current line
Map('n', '<leader>\\', ':TComment<cr>', { silent = true })
Map('x', '<leader>\\', ':TComment<cr>', { silent = true })

-- TODO: why does this work for multiple lines?
-- Map('n', '<leader>\\', '<cmd>TComment<cr>')
-- Map('x', '<leader>\\', '<cmd>TComment<cr>')

-- }}}
-- junegunn/fzf.vim {{{

function _G.search_files()
	-- If in a git repo and there is at least one commit use `GFiles`, otherwise use `Files`
	local handle = io.popen('[ "$(git rev-parse --is-inside-work-tree)" = "true" ] && [ "$(git count-objects | head -c 1)" -ne 0 ] && echo -n true')
	local result = handle:read('*a')
	handle:close()
	if result == "true" then
		vim.cmd 'GFiles --exclude-standard -c -o'
	else
		vim.cmd 'Files'
	end
end

-- Open a file using a fzf file search window
Map('n', '<c-p>', '<cmd>call v:lua.search_files()<cr>')
Map('n', '<leader>rf', '<cmd>call v:lua.search_files()<cr>')

-- Pick an open buffer to open
Map('n', '<leader>nb', '<cmd>Buffers<cr>')

-- Fuzzy search a project for a matching string using `ripgrep`
Map('n', '<leader>rg', '<cmd>Rg<cr>')

-- }}}
-- posva/vim-vue {{{

-- Rather than loading syntax files for all preprocessors and
-- trying each one, attempt to detect which need to be loaded
vim.g.vue_pre_processors = 'detect_on_enter'

-- }}}
-- junegunn/goyo.vim {{{

vim.g.goyo_width = 100

vim.g.goyo_linenr = 1

-- https://github.com/junegunn/goyo.vim/wiki/Customization#ensure-q-to-quit-even-when-goyo-is-active

function _G.goyo_enter()
	vim.b.quitting = 0
	vim.b.quitting_bang = 0
	vim.cmd 'autocmd QuitPre <buffer> let b:quitting = 1'
	vim.cmd 'cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!'
end

function _G.goyo_leave()
	-- if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1

	-- if vim.b.quitting then
	-- 	if vim.b.quitting_bang then
	-- 		vim.cmd 'qa!'
	-- 	else
	-- 		vim.cmd 'qa'
	-- 	end
	-- end
end

vim.cmd 'autocmd! User GoyoEnter call <sid>goyo_enter()'
vim.cmd 'autocmd! User GoyoLeave call <sid>goyo_leave()'

-- }}}
-- junegunn/vim-easy-align {{{

-- TODO: change these mappings...

-- Start interactive EasyAlign in visual mode (e.g. vipga)
-- Map('x', 'ga', '<Plug>(EasyAlign)')

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
-- Map('n', 'ga', '<Plug>(EasyAlign)')

-- }}}
-- christoomey/vim-tmux-navigator {{{

vim.g.tmux_navigator_no_mappings = true

Map('n', '<c-a><c-h>', '<cmd>TmuxNavigateLeft<cr>')
Map('n', '<c-a><c-j>', '<cmd>TmuxNavigateDown<cr>')
Map('n', '<c-a><c-k>', '<cmd>TmuxNavigateUp<cr>')
Map('n', '<c-a><c-l>', '<cmd>TmuxNavigateRight<cr>')
Map('n', '<c-a><c-w>', '<cmd>TmuxNavigatePrevious<cr>')

-- }}}
-- vimwiki/vimwiki {{{

-- TODO: use XDG_DIRS or for ~/Documents or maybe even an env variable for the notes dir

-- vim.g.vimwiki_list = {
-- 	{ path = '~/.local/share/vimwiki/default/', syntax = 'markdown', ext = '.md' },
-- 	{ path = '~/Documents/notes/', syntax = 'markdown', ext = '.md' },
-- }

vim.g.vimwiki_folding = 'expr'
vim.g.vimwiki_conceal_onechar_markers = 0

function _G.vimwiki_refresh_index()
	if vim.fn.expand('%:t') == 'index.md' then
		vim.cmd 'VimwikiRebuildTags'
		vim.cmd 'VimwikiGenerateTagLinks'
		vim.cmd 'VimwikiTOC'
	end
end

vim.cmd [[autocmd BufEnter,BufWritePre * if &ft ==# 'vimwiki' | :call v:lua.vimwiki_refresh_index) | endif]]
vim.cmd [[autocmd FileType vimwiki nmap <buffer> <c-]> <cr>]]

-- }}}
-- nvim-telescope/telescope.nvim {{{

Map('n', '<leader>ff', '<cmd>Telescope git_files<cr>')
Map('n', '<c-p>', '<cmd>Telescope git_files<cr>')
Map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
Map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
Map('n', '<leader>fv', '<cmd>Telescope git_status<cr>')

-- }}}
-- puremourning/vimspector {{{

vim.g.vimspector_enable_mappings = 'HUMAN'

-- }}}
-- ms-jpg/chadtree {{{

vim.g.chadtree_settings = {
	keymap = {
		primary = { '<space>', '<enter>' },
	},
}

-- }}}
-- hrsh7th/nvim-compe {{{

-- Required options for this plugin (but this is set in the settings module
-- set completeopt=menuone,noselect

vim.g.compe = {
	enabled = true,
	autocomplete = false,
	debug = false,
	min_length = 1,
	preselect = 'enable',
	throttle_time = 80,
	source_timeout = 200,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	documentation = true,
	source = {
		path = true,
		buffer = true,
		calc = true,
		nvim_lsp = true,
		nvim_lua = true,
		vsnip = false,
	}
}

-- inoremap <silent><expr> <c-space> compe#complete()
-- inoremap <silent><expr> <cr>      compe#confirm('<cr>')
-- " inoremap <silent><expr> <c-e>     compe#close('<c-e>')
-- inoremap <silent><expr> <c-d>     compe#scroll({ 'delta': +4 })
-- inoremap <silent><expr> <c-u>     compe#scroll({ 'delta': -4 })

-- }}}
-- RRethy/vim-hexokinase {{{

vim.g.Hexokinase_highlighters = { 'backgroundfull' }

-- }}}
-- hoob3rt/lualine.nvim {{{

local function lualine_lsp_info()
	if vim.lsp.buf.server_ready() then return 'LSP' else return '' end
end

local function lualine_readonly()
	if vim.o.readonly then return '[RO]' else return '' end
end

local function lualine_paste()
	if vim.o.paste then return 'PASTE' else return '' end
end

require('lualine').setup {
	options = {
		icons_enabled = false,
		component_separators = '|',
		section_separators = '',
	},
	sections = {
		lualine_a = { 'mode', lualine_paste },
		lualine_b = { 'filename', lualine_readonly },
		lualine_c = {},

		lualine_x = {},
		lualine_y = { 'filetype', lualine_lsp_info },
		-- TODO:
		-- lualine_z = { 'lineinfo' },
		lualine_z = {},
	},
	-- tabline = {},
}

-- }}}

-- vim:foldmethod=marker:foldlevel=0
