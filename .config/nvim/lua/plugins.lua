local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lazy_colors = false

-- For lua line

local function lualine_lsp_info()
	if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then return 'LSP' else return '' end
end

local function lualine_paste()
	if vim.o.paste then return 'PASTE' else return '' end
end

-- TODO: can I move this? Or does it need to be before the colorschemes?
-- Actually I think I can move it cuz they are lazy loaded
vim.o.background = 'dark'

require('lazy').setup({

	-- Colorschemes

	{ 'RRethy/base16-nvim', lazy = lazy_colors },
	{ 'tyrannicaltoucan/vim-deep-space', lazy = lazy_colors },
	{ 'tyrannicaltoucan/vim-quantum', lazy = lazy_colors },
	{ 'ronny/birds-of-paradise.vim', lazy = lazy_colors },
	{ 'skbolton/embark', lazy = lazy_colors },
	{ 'Rigellute/shades-of-purple.vim', lazy = lazy_colors },
	{
		'srcery-colors/srcery-vim',
		lazy = lazy_colors,
		name = 'srcery',
		config = function()
			vim.g.srcery_inverse = 0
		end,
	},
	{
		'chuling/equinusocio-material.vim',
		lazy = lazy_colors,
		config = function()
			vim.g.equinusocio_material_style = 'pure'
		end,
	},
	{ 'nightsense/strawberry', lazy = lazy_colors },
	{ 'nightsense/vimspectr', lazy = lazy_colors },
	{ 'addisonbean/amber', lazy = lazy_colors },
	{ 'metalelf0/base16-black-metal-scheme', lazy = lazy_colors },
	-- This isn't on GitHub anymore :(
	-- 'co1ncidence/bliss',
	{ 'logico/typewriter-vim', lazy = lazy_colors },
	{ 'arcticicestudio/nord-vim', lazy = lazy_colors },
	{ 'arzg/vim-colors-xcode', lazy = lazy_colors },
	{
		'pineapplegiant/spaceduck',
		lazy = lazy_colors,
		config = function()
			vim.api.nvim_create_augroup('spaceduck_fixes', { clear = true })
			vim.api.nvim_create_autocmd('ColorScheme', {
				pattern = 'spaceduck',
				group = 'spaceduck_fixes',
				command = 'hi Comment ctermfg=237 guifg=#575b73',
			})
		end,
	},
	{ 'kyazdani42/blue-moon', lazy = lazy_colors },
	{ 'danishprakash/vim-yami', lazy = lazy_colors },
	{ 'plan9-for-vimspace/acme-colors', lazy = lazy_colors },
	{ 'mangeshrex/uwu.vim', lazy = lazy_colors },

	-- Language specific

	{ 'mattn/emmet-vim', ft = { 'html', 'eruby', 'php', 'xml', 'vue', 'js', 'typescript', 'typescriptreact' } },
	{ 'neovimhaskell/haskell-vim', ft = 'haskell' },
	{ 'rudes/vim-java', ft = 'java' },
	{ 'cespare/vim-toml', ft = 'toml' },
	{ 'maxmellon/vim-jsx-pretty', ft = 'js' },
	{ 'ElmCast/elm-vim', ft = 'elm' },
	{ 'edwinb/idris2-vim', ft = 'idr' },
	{ 'pangloss/vim-javascript', ft = 'js' },
	{ 'leafgarland/typescript-vim', ft = 'typescript' },
	{ 'lervag/vimtex', ft = 'latex' },
	{ 'sbdchd/neoformat', cmd = 'Neoformat' },
	-- { 'whatyouhide/vim-textobj-xmlattr', dependencies = 'kana/vim-textobj-user' },
	{ 'inside/vim-textobj-jsxattr', dependencies = 'kana/vim-textobj-user', ft = { 'xml', 'html', 'typescriptreact' } },
	{ 'pirmd/gemini.vim', ft = 'gemini' },
	{ 'rodjek/vim-puppet', ft = 'puppet' },
	-- '~/code/projects/loclist-toc-nvim/',
	{
		'addisonbean/loclist-toc-nvim',
		config = function()
			vim.cmd [[autocmd FileType markdown,vimwiki nnoremap <buffer> <silent> <leader>tt :lua require('loclist-toc-nvim').make_markdown_toc()<cr>]]
		end,
	},
	{ 'hashivim/vim-terraform', ft = 'terraform' },
	{
		'farconics/victionary',
		ft = { 'text', 'markdown' },
		init = function()
			vim.g['victionary#map_defaults'] = false
		end,
	},
	-- This one is cool but I don't wanna get the config how I want rn
	-- {
	-- 	'OXY2DEV/markview.nvim',
	-- 	ft = 'markdown',
	-- 	dependencies = {
	-- 		'nvim-treesitter/nvim-treesitter',
	-- 		'nvim-tree/nvim-web-devicons'
	-- 	},
	-- },
	{ 'elkowar/yuck.vim', ft = 'yuck' },

	-- Misc plugins

	'tpope/vim-surround',
	{
		'lewis6991/gitsigns.nvim',
		dependencies = 'nvim-lua/plenary.nvim',
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require('gitsigns')
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation

				map('n', ']c', function()
					if vim.wo.diff then
						vim.cmd.normal({']c', bang = true})
					else
						gitsigns.nav_hunk('next')
					end
				end)

				map('n', '[c', function()
					if vim.wo.diff then
						vim.cmd.normal({'[c', bang = true})
					else
						gitsigns.nav_hunk('prev')
					end
				end)

				-- Actions

				map('n', '<leader>hs', gitsigns.stage_hunk)
				map('n', '<leader>hr', gitsigns.reset_hunk)
				map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
				map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
				map('n', '<leader>hS', gitsigns.stage_buffer)
				map('n', '<leader>hu', gitsigns.undo_stage_hunk)
				map('n', '<leader>hR', gitsigns.reset_buffer)
				map('n', '<leader>hp', gitsigns.preview_hunk)
				map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
				map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
				map('n', '<leader>hd', gitsigns.diffthis)
				map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
				map('n', '<leader>td', gitsigns.toggle_deleted)

				-- Text object

				map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
			end
		},
	},
	'tpope/vim-sleuth',

	-- TODO: these may not be needed once this is fixed https://github.com/neovim/neovim/issues/28872
	{
		'tomtom/tcomment_vim',
		keys = {
			{ '<leader>\\', ':TComment<cr>', mode = { 'n', 'x' }, silent = true }
		},
	},

	-- and this doesn't seem to work, at least how I expect...
	-- 'folke/ts-comments.nvim',

	{ 'Pocco81/TrueZen.nvim', cmd = { 'TZAtaraxis', 'TZMinimalist', 'TZFocus' } },
	{ 'junegunn/limelight.vim', cmd = 'Limelight' },
	'mjbrownie/swapit',
	{
		'junegunn/vim-easy-align',
		keys = {
			-- TODO: find a new mapping for this
			-- { 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'x' } },
		},
	},
	'tpope/vim-repeat',
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			options = {
				icons_enabled = false,
				component_separators = '|',
				section_separators = '',
				theme = require('lualine_theme'),
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
		},
	},
	-- 'christoomey/vim-tmux-navigator',
	'lifepillar/vim-colortemplate',
	'tpope/vim-abolish',
	'neovim/nvim-lspconfig',
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{ 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = 'nvim-treesitter/nvim-treesitter' },
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
		-- I have to do this here because importing modules in `opts` breaks
		config = function()
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
		end,
		keys = {
			{
				'<c-p>',
				function()
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
			},
			{ '<leader>ff', '<cmd>Telescope live_grep<cr>' },
			{ '<leader>fb', '<cmd>Telescope buffers<cr>' },
			{ '<leader>fv', '<cmd>Telescope git_status<cr>' },
		},
	},
	-- Since 0.11, all this would add that I may want is the ability to show docs along side completion suggestions
	-- It can also aggregate results from multiple sources too
	-- 'hrsh7th/nvim-cmp',
	'AndrewRadev/splitjoin.vim',
	{ 'simrat39/symbols-outline.nvim', cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen' } },
	{
		'chrisbra/Colorizer',
		keys = {
			{ '<leader>sh', '<cmd>ColorToggle<cr>' },
		},
	},

	-- A snippet plugin is needed for cssls to support autocomplete
	-- { 'SirVer/ultisnips', dependencies = { 'hrsh7th/nvim-compe' } },

	{
		'Konfekt/FastFold',
		config = function()
			vim.g.markdown_folding = 1
			-- vim.opt.sessionoptions:remove('folds')
		end,
	},
	{
		'obsidian-nvim/obsidian.nvim',
		version = '*',
		lazy = true,
		ft = 'markdown',
		event = {
			'BufReadPre ' .. vim.env.XDG_DOCUMENTS_DIR .. '/obsidian/**.md',
			'BufNewFile ' .. vim.env.XDG_DOCUMENTS_DIR .. '/obsidian/**.md',
		},
		dependencies = {
			'nvim-lua/plenary.nvim', -- required
		},
		opts = {
			legacy_commands = false,
			templates = {
				subdir = 'templates'
			},
			workspaces = {
				{
					name = 'notes',
					path = vim.env.XDG_DOCUMENTS_DIR .. '/obsidian',
				},
			},
			ui = {
				max_file_length = 3000, -- this is in lines
				bullets = {},
			},
			checkboxes = {},
			callbacks = {
				enter_note = function(_, note)
					vim.keymap.set("n", "<c-space>", "<cmd>Obsidian toggle_checkbox<cr>", { buffer = note.bufnr })
					vim.keymap.set("n", "gf", "<cmd>Obsidian follow_link<cr>", { buffer = note.bufnr })
					vim.keymap.set("n", "<cr>", "<cmd>Obsidian follow_link<cr>", { buffer = note.bufnr })
				end,
			},
			follow_url_func = function(url)
				vim.fn.jobstart({ 'xdg-open', url })  -- linux
			end,
		},
	},
})
