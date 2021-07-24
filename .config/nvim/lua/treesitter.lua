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

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.typescript.used_by = 'typescriptreact'

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
