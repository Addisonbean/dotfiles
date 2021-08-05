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
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '[D', '<cmd>lua vim.lsp.diagnostic.goto_prev({ severity_limit = "Error" })<CR>', opts)
    buf_set_keymap('n', ']D', '<cmd>lua vim.lsp.diagnostic.goto_next({ severity_limit = "Error" })<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>gd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
    buf_set_keymap('n', '<leader>gE', '<cmd>lua vim.lsp.diagnostic.set_loclist({ workspace = true, severity_limit = "Error" })<CR>', opts)
    buf_set_keymap('n', '<leader>ge', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
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

-- Lua

-- TODO: assume it's in the path
-- local sumneko_root_path = vim.fn.stdpath('data')..'/lsp-servers/lua-language-server'
-- local sumneko_binary = sumneko_root_path..'/bin/'..system_name..'/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- C#
local pid = vim.fn.getpid()
local omnisharp_bin = "/Users/addison.bean/work/misc/omnisharp-osx/run"

local extra_settings = {
    omnisharp = {
	cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
	-- root_dir = nvim_lsp.util.root_pattern("*.sln"),
    },
    sumneko_lua = {
	-- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" };
	cmd = { 'lua-language-server' };
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
}

local servers = { 'cssls', 'ghcide', 'html', 'pylsp', 'rust_analyzer', 'vimls', 'tsserver', 'bashls', 'omnisharp', 'sumneko_lua' }
for _, lsp in ipairs(servers) do
    -- TODO: make a `merge` util function
    local settings = {
	on_attach = on_attach,
	capabilities = capabilities,
    }
    if extra_settings[lsp] ~= nil then
	for k,v in pairs(extra_settings[lsp]) do
	    settings[k] = v
	end
    end
    nvim_lsp[lsp].setup(settings)
end
