local nvim_lsp = require('lspconfig')

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- I use telescope.nvim for references via. `gr` instead of this
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '[D', function()
	vim.diagnostic.goto_prev({ severity_limit = "Error" })
    end, opts)
    vim.keymap.set('n', ']D', function()
	vim.diagnostic.goto_next({ severity_limit = "Error" })
    end, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>gd', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>gE', function()
	vim.diagnostic.setloclist({ workspace = true, severity_limit = "Error" })
    end, opts)
    vim.keymap.set('n', '<leader>ge', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, opts)

    -- TODO: Should I be using the `range argument here?
    vim.keymap.set('v', 'ga', vim.lsp.buf.code_action, opts)

    -- telescope.nvim mappings
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.codeAction = {
    dynamicRegistration = false,
    codeActionLiteralSupport = {
	codeActionKind = {
	    valueSet = (function()
		local res = vim.tbl_values(vim.lsp.protocol.CodeActionKind)
		table.sort(res)
		return res
	    end)()
	}
    }
}
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Lua settings

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- C# settings
local pid = vim.fn.getpid()
-- local omnisharp_bin = "/path/to/omnisharp-repo/run"

-- typescript/vue/volar settings
local vue_language_server_path = '/usr/lib/node_modules/@vue/language-server'

local extra_settings = {
    lua_ls = {
	settings = {
	    Lua = {
		runtime = {
		    version = 'LuaJIT',
		    path = runtime_path,
		},
		diagnostics = {
		    globals = { 'vim' },
		},
		workspace = {
		    library = vim.api.nvim_get_runtime_file("", true),
		    checkThirdParty = false,
		},
		telemetry = {
		    enable = false,
		},
	    },
	},
    },
    hls = {
	root_dir = require'lspconfig'.util.root_pattern("*"),
	-- root_dir = root_pattern("*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml", ".")
    },
    omnisharp = {
	cmd = { "omnisharp", "--languageserver" , "--hostPID", tostring(pid) },
    },
    tsserver = {
	init_options = {
	    plugins = {
		{
		    name = '@vue/typescript-plugin',
		    location = vue_language_server_path,
		    languages = { 'vue' },
		},
	    },
	},
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    },
}

local servers = { 'cssls', 'hls', 'html', 'pylsp', 'rust_analyzer', 'vimls', 'tsserver', 'bashls', 'omnisharp', 'lua_ls', 'eslint', 'terraformls', 'volar' }

for _, server in pairs(servers) do
    local settings = {
	capabilities = capabilities,
    }
    if extra_settings[server] ~= nil then
	settings = vim.tbl_extend('force', settings, extra_settings[server])
    end
    nvim_lsp[server].setup(settings)
end
