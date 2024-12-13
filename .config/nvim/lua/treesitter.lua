require'nvim-treesitter.configs'.setup {
    auto_install = true,
    -- ensure_installed = { 'markdown', 'markdown_inline' },
    highlight = {
	enable = true,
	disable = {
	    -- TODO: disabled something in rust-tools instead of this? https://www.reddit.com/r/neovim/comments/10bx4vi/rusttools_breaks_treesitter_highlighting/
	    -- 'rust',
	    'markdown',
	    -- 'javascript',
	    -- 'vue',
	},
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

-- local ft_to_parser = require'nvim-treesitter.parsers'.filetype_to_parsername
-- ft_to_parser.typescriptreact = 'typescript'

-- Which one replaces the code above??? Idk...

-- vim.treesitter.language.register('typescriptreact', 'typescript')
-- vim.treesitter.language.register('typescript', 'typescriptreact')

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
