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

local lazy_colors = true

require('lazy').setup({

	-- Colorschemes

	{ 'chriskempson/base16-vim', lazy = lazy_colors },
	{ 'morhetz/gruvbox', lazy = lazy_colors },
	{ 'tyrannicaltoucan/vim-deep-space', lazy = lazy_colors },
	{ 'tyrannicaltoucan/vim-quantum', lazy = lazy_colors },
	{ 'ronny/birds-of-paradise.vim', lazy = lazy_colors },
	{ 'ayu-theme/ayu-vim', lazy = lazy_colors },
	{ 'skbolton/embark', lazy = lazy_colors },
	{ 'Rigellute/shades-of-purple.vim', lazy = lazy_colors },
	{ 'srcery-colors/srcery-vim', name = 'srcery', lazy = lazy_colors },
	{ 'chuling/equinusocio-material.vim', lazy = lazy_colors },
	{ 'nightsense/strawberry', lazy = lazy_colors },
	{ 'nightsense/vimspectr', lazy = lazy_colors },
	{ 'addisonbean/amber', lazy = lazy_colors },
	{ 'metalelf0/base16-black-metal-scheme', lazy = lazy_colors },
	-- This isn't on GitHub anymore :(,
	-- 'co1ncidence/bliss',
	{ 'logico/typewriter-vim', lazy = lazy_colors },
	{ 'arcticicestudio/nord-vim', lazy = lazy_colors },
	{ 'arzg/vim-colors-xcode', lazy = lazy_colors },
	{ dir = '~/code/projects/srcery-basic', lazy = lazy_colors },
	{ 'pineapplegiant/spaceduck', lazy = lazy_colors },
	{ 'kyazdani42/blue-moon', lazy = lazy_colors },
	{ 'danishprakash/vim-yami', lazy = lazy_colors },
	{ 'plan9-for-vimspace/acme-colors', lazy = lazy_colors },
	{ 'mangeshrex/uwu.vim', lazy = lazy_colors },

	-- Language specific

	{ 'mattn/emmet-vim', ft = { 'html', 'eruby', 'php', 'xml', 'vue', 'js', 'typescript', 'typescriptreact' } },
	{ 'neovimhaskell/haskell-vim', ft = 'haskell' },
	{ 'rudes/vim-java', ft = 'java' },
	{ 'cespare/vim-toml', ft = 'toml' },
	{ 'posva/vim-vue', ft = 'vue' },
	{ 'maxmellon/vim-jsx-pretty', ft = 'js' },
	{ 'ElmCast/elm-vim', ft = 'elm' },
	{ 'edwinb/idris2-vim', ft = 'idr' },
	{ 'pangloss/vim-javascript', ft = 'js' },
	{ 'leafgarland/typescript-vim', ft = 'typescript' },
	{ 'lervag/vimtex', ft = 'latex' },
	{ 'mfussenegger/nvim-dap' },
	{ 'sbdchd/neoformat', cmd = 'Neoformat' },
	-- { 'whatyouhide/vim-textobj-xmlattr', dependencies = 'kana/vim-textobj-user' },
	{ 'inside/vim-textobj-jsxattr', dependencies = 'kana/vim-textobj-user', ft = { 'xml', 'html', 'typescriptreact' } },
	{ 'pirmd/gemini.vim', ft = 'gemini' },
	{ 'rodjek/vim-puppet', ft = 'puppet' },
	{ 'addisonbean/loclist-toc-nvim' },
	-- '~/code/projects/loclist-toc-nvim/',
	{ 'hashivim/vim-terraform', ft = 'terraform' },
	{ 'farconics/victionary', ft = { 'text', 'markdown' } },
	{ 'Rykka/riv.vim', ft = 'rst' },

	-- Misc plugins

	'tpope/vim-surround',
	{ 'lewis6991/gitsigns.nvim', dependencies = 'nvim-lua/plenary.nvim' },
	'tpope/vim-sleuth',
	'tomtom/tcomment_vim',
	{ 'Pocco81/TrueZen.nvim', cmd = { 'TZAtaraxis', 'TZMinimalist', 'TZFocus' } },
	{ 'junegunn/limelight.vim', cmd = 'Limelight' },
	'mjbrownie/swapit',
	'junegunn/vim-easy-align',
	'tpope/vim-repeat',
	'hoob3rt/lualine.nvim',
	'christoomey/vim-tmux-navigator',
	'lifepillar/vim-colortemplate',
	-- 'vimwiki/vimwiki',
	{ 'RRethy/vim-hexokinase', ft = 'css', build = 'make hexokinase' },
	'tpope/vim-abolish',
	{ 'junegunn/fzf.vim', dependencies = 'junegunn/fzf' },
	'neovim/nvim-lspconfig',
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{ 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = 'nvim-treesitter/nvim-treesitter' },
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
	},
	'AndrewRadev/splitjoin.vim',
	{ 'simrat39/symbols-outline.nvim', cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen' } },
	'chrisbra/Colorizer',

	-- 'karb94/neoscroll.nvim',

	-- A snippet plugin is needed for cssls to support autocomplete
	-- { 'SirVer/ultisnips', dependencies = { 'hrsh7th/nvim-compe' } },

	'Konfekt/FastFold',

	-- This isn't working :/
	-- {
	-- 	'hrsh7th/nvim-cmp',
	-- 	opts = {
	-- 		mapping = {
	-- 			["<C-n>"] = require'cmp'.mapping.select_next_item({ behavior = require'cmp'.SelectBehavior.Select }),
	-- 			["<C-p>"] = require'cmp'.mapping.select_prev_item({ behavior = require'cmp'.SelectBehavior.Select }),
	-- 		},
	-- 	},
	-- },
	{
		'epwalsh/obsidian.nvim',
		version = "*",
		lazy = true,
		ft = 'markdown',
		event = {
			'BufReadPre ' .. vim.env.XDG_DOCUMENTS_DIR .. '/obsidian/**.md',
			'BufNewFile ' .. vim.env.XDG_DOCUMENTS_DIR .. '/obsidian/**.md',
		},
		dependencies = {
			'nvim-lua/plenary.nvim', -- required
			'hrsh7th/nvim-cmp',
		},
		opts = {
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
				checkboxes = {},
				bullets = {},
			},
			mappings = {
				["<c-space>"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				["<cr>"] = {
					action = function()
						-- Or the smart action?
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
			},
			follow_url_func = function(url)
				vim.fn.jobstart({ 'xdg-open', url })  -- linux
			end,
		},
	},
})
