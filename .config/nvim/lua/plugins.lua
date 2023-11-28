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

require('lazy').setup({

	-- Colorschemes

	{ 'chriskempson/base16-vim', lazy = true },
	{ 'morhetz/gruvbox', lazy = true },
	{ 'tyrannicaltoucan/vim-deep-space', lazy = true },
	{ 'tyrannicaltoucan/vim-quantum', lazy = true },
	{ 'ronny/birds-of-paradise.vim', lazy = true },
	{ 'ayu-theme/ayu-vim', lazy = true },
	{ 'skbolton/embark', lazy = true },
	{ 'Rigellute/shades-of-purple.vim', lazy = true },
	{ 'srcery-colors/srcery-vim', name = 'srcery', lazy = true },
	{ 'chuling/equinusocio-material.vim', lazy = true },
	{ 'nightsense/strawberry', lazy = true },
	{ 'nightsense/vimspectr', lazy = true },
	{ 'addisonbean/amber', lazy = true },
	{ 'metalelf0/base16-black-metal-scheme', lazy = true },
	-- This isn't on GitHub anymore :(,
	-- 'co1ncidence/bliss',
	{ 'logico/typewriter-vim', lazy = true },
	{ 'arcticicestudio/nord-vim', lazy = true },
	{ 'arzg/vim-colors-xcode', lazy = true },
	{ dir = '~/code/projects/srcery-basic', lazy = true },
	{ 'pineapplegiant/spaceduck', lazy = true },
	{ 'kyazdani42/blue-moon', lazy = true },
	{ 'danishprakash/vim-yami', lazy = true },
	{ 'plan9-for-vimspace/acme-colors', lazy = true },
	{ 'mangeshrex/uwu.vim', lazy = true },

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
	'vimwiki/vimwiki',
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
})

-- return require('packer').startup(function(use)
-- 	use 'wbthomason/packer.nvim'
--
-- 	colorscheme_plugins(use)
-- 	language_feature_plugins(use)
-- 	misc_plugins(use)
-- end)
