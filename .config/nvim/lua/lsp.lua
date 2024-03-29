local nvim_lsp = require('lspconfig')

local function on_attach(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    -- I use telescope.nvim for references via. `gr` instead of this
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    buf_set_keymap('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '[D', '<cmd>lua vim.diagnostic.goto_prev({ severity_limit = "Error" })<CR>', opts)
    buf_set_keymap('n', ']D', '<cmd>lua vim.diagnostic.goto_next({ severity_limit = "Error" })<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>gd', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    buf_set_keymap('n', '<leader>gE', '<cmd>lua vim.diagnostic.setloclist({ workspace = true, severity_limit = "Error" })<CR>', opts)
    buf_set_keymap('n', '<leader>ge', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    -- TODO: Should I be using the `range argument here?
    buf_set_keymap('v', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    -- telescope.nvim mappings
    buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
end

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

local extra_settings = {
    sumneko_lua = {
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
}

local servers = { 'cssls', 'hls', 'html', 'pylsp', 'rust_analyzer', 'vimls', 'tsserver', 'bashls', 'omnisharp', 'lua_ls', 'eslint', 'terraformls' }

-- Use `:LspInstall` to install servers via. `kabouzeid/nvim-lspinstall`
-- require'lspinstall'.setup()
-- local servers = require'lspinstall'.installed_servers()

for _, server in pairs(servers) do
    local settings = {
	on_attach = on_attach,
	capabilities = capabilities,
    }
    if extra_settings[server] ~= nil then
	settings = vim.tbl_extend('force', settings, extra_settings[server])
    end
    nvim_lsp[server].setup(settings)
end
