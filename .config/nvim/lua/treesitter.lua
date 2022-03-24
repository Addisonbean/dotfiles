require'nvim-treesitter.configs'.setup {
    highlight = {
	enable = true,
	disable = { 'rust' },
    },
    textobjects = {
	select = {
	    enable = true,
	    keymaps = {
		['af'] = '@function.outer',
		['if'] = '@function.inner',
		['ac'] = '@class.outer',
		['ic'] = '@class.inner',
	    },
	},
    },
}

local ft_to_parser = require'nvim-treesitter.parsers'.filetype_to_parsername
ft_to_parser.typescriptreact = 'typescript'

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
