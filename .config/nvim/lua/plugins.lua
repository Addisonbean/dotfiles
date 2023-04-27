local function colorscheme_plugins(use)
	use 'chriskempson/base16-vim'
	use 'morhetz/gruvbox'
	use 'tyrannicaltoucan/vim-deep-space'
	use 'tyrannicaltoucan/vim-quantum'
	use 'ronny/birds-of-paradise.vim'
	use 'ayu-theme/ayu-vim'
	use 'skbolton/embark'
	use 'Rigellute/shades-of-purple.vim'
	use { 'srcery-colors/srcery-vim', as = 'srcery' }
	use 'chuling/equinusocio-material.vim'
	use 'nightsense/strawberry'
	use 'nightsense/vimspectr'
	use 'addisonbean/amber'
	use 'metalelf0/base16-black-metal-scheme'
	-- This isn't on GitHub anymore :(
	-- use 'co1ncidence/bliss'
	use 'logico/typewriter-vim'
	use 'arcticicestudio/nord-vim'
	use 'arzg/vim-colors-xcode'
	use '~/code/projects/srcery-basic'
	use 'pineapplegiant/spaceduck'
	use 'kyazdani42/blue-moon'
	use 'danishprakash/vim-yami'
	use 'plan9-for-vimspace/acme-colors'
	use 'mangeshrex/uwu.vim'
end

local function language_feature_plugins(use)
	use { 'mattn/emmet-vim', ft = { 'html', 'eruby', 'php', 'xml', 'vue', 'js', 'typescript', 'typescriptreact' } }
	use { 'neovimhaskell/haskell-vim', ft = 'haskell' }
	use { 'rudes/vim-java', ft = 'java' }
	use { 'cespare/vim-toml', ft = 'toml' }
	use { 'posva/vim-vue', ft = 'vue' }
	use { 'maxmellon/vim-jsx-pretty', ft = 'js' }
	use { 'ElmCast/elm-vim', ft = 'elm' }
	use { 'edwinb/idris2-vim', ft = 'idr' }
	use { 'pangloss/vim-javascript', ft = 'js' }
	use { 'leafgarland/typescript-vim', ft = 'typescript' }
	use { 'lervag/vimtex', ft = 'latex' }
	use { 'mfussenegger/nvim-dap' }
	use { 'sbdchd/neoformat', cmd = 'Neoformat' }
	-- use { 'whatyouhide/vim-textobj-xmlattr', requires = 'kana/vim-textobj-user' }
	use { 'inside/vim-textobj-jsxattr', requires = 'kana/vim-textobj-user', ft = { 'xml', 'html', 'typescriptreact' } }
	use { 'pirmd/gemini.vim', ft = 'gemini' }
	use { 'rodjek/vim-puppet', ft = 'puppet' }
	use { 'addisonbean/loclist-toc-nvim' }
	-- use '~/code/projects/loclist-toc-nvim/'
	use { 'hashivim/vim-terraform', ft = 'terraform' }
	use { 'farconics/victionary', ft = { 'text', 'markdown' } }
	use { 'Rykka/riv.vim', ft = 'rst' }
end

local function misc_plugins(use)
	use 'tpope/vim-surround'
	use { 'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim' }
	use 'tpope/vim-sleuth'
	use 'tomtom/tcomment_vim'
	use { 'Pocco81/TrueZen.nvim', cmd = { 'TZAtaraxis', 'TZMinimalist', 'TZFocus' } }
	use { 'junegunn/limelight.vim', cmd = 'Limelight' }
	use 'mjbrownie/swapit'
	use 'junegunn/vim-easy-align'
	use 'tpope/vim-repeat'
	use 'hoob3rt/lualine.nvim'
	use 'christoomey/vim-tmux-navigator'
	use 'lifepillar/vim-colortemplate'
	use 'vimwiki/vimwiki'
	use { 'RRethy/vim-hexokinase', ft = 'css', run = 'make hexokinase' }
	use 'tpope/vim-abolish'
	use { 'junegunn/fzf.vim', requires = 'junegunn/fzf' }
	use 'neovim/nvim-lspconfig'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'nvim-treesitter/nvim-treesitter-textobjects', requires = 'nvim-treesitter/nvim-treesitter' }
	use {
		'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
	}
	use 'AndrewRadev/splitjoin.vim'
	use { 'simrat39/symbols-outline.nvim', cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen' } }
	use 'chrisbra/Colorizer'

	-- use 'karb94/neoscroll.nvim'

	-- A snippet plugin is needed for cssls to support autocomplete
	-- use { 'SirVer/ultisnips', requires = { 'hrsh7th/nvim-compe' } }

	use 'Konfekt/FastFold'
end

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	colorscheme_plugins(use)
	language_feature_plugins(use)
	misc_plugins(use)
end)
