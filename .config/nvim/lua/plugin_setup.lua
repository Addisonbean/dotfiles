-- This file includes plugin settings AND plugin mappings

local map = require('util').map
local bufmap = require('util').bufmap

-- tomtom/tcomment_vim {{{

-- Comment/uncomment the current line
map('n', '<leader>\\', ':TComment<cr>', { silent = true })
map('x', '<leader>\\', ':TComment<cr>', { silent = true })

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
-- map('n', '<c-p>', '<cmd>call v:lua.search_files()<cr>')
map('n', '<leader>rf', '<cmd>call v:lua.search_files()<cr>')

-- Pick an open buffer to open
map('n', '<leader>nb', '<cmd>Buffers<cr>')

-- Fuzzy search a project for a matching string using `ripgrep`
map('n', '<leader>rg', '<cmd>Rg<cr>')

-- }}}
-- posva/vim-vue {{{

-- Rather than loading syntax files for all preprocessors and
-- trying each one, attempt to detect which need to be loaded
vim.g.vue_pre_processors = 'detect_on_enter'

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

map('n', '<c-a><c-h>', '<cmd>TmuxNavigateLeft<cr>')
map('n', '<c-a><c-j>', '<cmd>TmuxNavigateDown<cr>')
map('n', '<c-a><c-k>', '<cmd>TmuxNavigateUp<cr>')
map('n', '<c-a><c-l>', '<cmd>TmuxNavigateRight<cr>')
map('n', '<c-a><c-w>', '<cmd>TmuxNavigatePrevious<cr>')

-- }}}
-- vimwiki/vimwiki {{{

-- TODO: use XDG_DIRS or for ~/Documents or maybe even an env variable for the notes dir

vim.g.vimwiki_list = {
	{ path = '~/.local/share/vimwiki/default/', syntax = 'markdown', ext = '.md' },
}

if vim.env.XDG_DOCUMENTS_DIR ~= nil then
	local vimwiki_notes_dir = vim.env.XDG_DOCUMENTS_DIR .. '/notes'
	table.insert(vim.g.vimwiki_list, { path = vimwiki_notes_dir, syntax = 'markdown', ext = '.md' })
end

vim.g.vimwiki_folding = 'expr'
vim.g.vimwiki_conceal_onechar_markers = 0

function _G.vimwiki_refresh_index()
	if vim.fn.expand('%:t') == 'index.md' then
		vim.cmd 'VimwikiRebuildTags'
		vim.cmd 'VimwikiGenerateTagLinks'
		vim.cmd 'VimwikiTOC'
	end
end

vim.cmd [[autocmd BufEnter,BufWritePre * if &ft ==# 'vimwiki' | :call v:lua.vimwiki_refresh_index() | endif]]
vim.cmd [[autocmd FileType vimwiki nmap <buffer> <c-]> <cr>]]

-- }}}
-- nvim-telescope/telescope.nvim {{{

function _G.search_files()
	-- If in a git repo and there is at least one commit use `git_files`, otherwise use `find_files`
	local handle = io.popen('[ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = "true" ] && [ "$(git count-objects | head -c 1)" -ne 0 ] && echo -n true')
	local result = handle:read('*a')
	handle:close()
	if result == 'true' then
		vim.cmd 'Telescope git_files'
	else
		vim.cmd 'Telescope find_files'
	end
end

map('n', '<c-p>', '<cmd>call v:lua.search_files()<cr>')

-- map('n', '<c-p>', '<cmd>Telescope git_files<cr>')
map('n', '<leader>ff', '<cmd>Telescope git_files<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fv', '<cmd>Telescope git_status<cr>')

local actions = require('telescope.actions')

require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				['<c-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
			},
			n = {
				['<c-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
			},
		},
	},
}
-- }}}
-- puremourning/vimspector {{{

vim.g.vimspector_enable_mappings = 'HUMAN'

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

local function lualine_paste()
	if vim.o.paste then return 'PASTE' else return '' end
end

local theme = require('lualine_theme')

require('lualine').setup {
	options = {
		icons_enabled = false,
		component_separators = '|',
		section_separators = '',
		theme = theme,
	},
	sections = {
		lualine_a = { 'mode', lualine_paste },
		lualine_b = { 'filename' },
		lualine_c = {},

		lualine_x = {},
		lualine_y = { 'filetype', lualine_lsp_info },
		lualine_z = { 'location' },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = { 'filename' },
		lualine_c = {},

		lualine_x = {},
		lualine_y = { 'filetype', lualine_lsp_info },
		lualine_z = {},
	},
}

-- }}}
-- lewis6991/gitsigns.nvim {{{

require('gitsigns').setup {
	on_attach = function(bufnr)
		-- Navigation
		map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
		map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

		-- Actions
		map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', { silent = true })
		map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>', { silent = true })
		map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', { silent = true })
		map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>', { silent = true })
		map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>', { silent = true })
		map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', { silent = true })
		map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>', { silent = true })
		map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>', { silent = true })
		map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', { silent = true })
		map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>', { silent = true })
		map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>', { silent = true })
		map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>', { silent = true })
		map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>', { silent = true })

		-- Text object
		map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>', { silent = true })
		map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>', { silent = true })
	end
}

-- }}}
-- mfussenegger/nvim-dap {{{

local dap = require('dap')

dap.adapters.netcoredbg = {
	type = 'executable',
	command = 'netcoredbg',
	-- command = '/Users/addison.bean/misc/netcoredbg/netcoredbg',
	args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
	{
		type = "netcoredbg",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
		end,
	},
}

-- }}}
-- {{{ Addisonbean/loclist-toc-nvim

require('loclist-toc-nvim').setup{}

vim.cmd [[autocmd FileType markdown,vimwiki nnoremap <buffer> <silent> <leader>tt :lua require('loclist-toc-nvim').make_markdown_toc()<cr>]]

-- }}}
-- {{{ farconics/victionary

vim.g['victionary#map_defaults'] = false

-- nmap <mapping> <Plug>(victionary#define_under_cursor)

map('n', 'K', '')

-- }}}
-- {{{ chrisbra/Colorizer

map('n', '<leader>sh', '<cmd>ColorToggle<cr>')

-- }}}

-- Colorscheme options

vim.g.seoul256_background = 233
vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd('let ayucolor = "dark"')
vim.g.equinusocio_material_style = 'pure'
vim.g.srcery_inverse = 0
vim.o.background = 'dark'

vim.cmd [[
	augroup colorscheme_fixes
		au!
		au ColorScheme spaceduck hi Comment ctermfg=237 guifg=#575b73
	augroup END
]]

-- vim:foldmethod=marker:foldlevel=0
