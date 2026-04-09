local coq = require "coq"

local map = vim.keymap.set

local on_attach = function(client, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = "LSP " .. desc }
    end

    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

    -- map("n", "<leader>wl", function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts "List workspace folders")

    map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
    vim.keymap.set("n", "<Leader>ra", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = bufnr })

    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    map("n", "gr", vim.lsp.buf.references, opts "Show references")

    vim.keymap.set("n", "gd", "<cmd> Telescope lsp_definitions <cr>", { buffer = bufnr })
    vim.keymap.set("n", "gr", "<cmd> Telescope lsp_references <cr>", { buffer = bufnr })
    vim.keymap.set("n", "gi", "<cmd> Telescope lsp_implementations <cr>", { buffer = bufnr })

    -- vim virtual text diagnostics toggle
    vim.keymap.set("n", "<leader>tdd", function()
        vim.diagnostic.config {
            virtual_lines = not vim.diagnostic.config().virtual_lines,
            virtual_text = not vim.diagnostic.config().virtual_text,
        }
    end, { desc = "toggle diagnostic" })

    -- if client.name == 'gopls' then
    --   client.server_capabilities.semanticTokensProvider = {
    --     full = true,
    --     legend = {
    --       tokenTypes = { 'namespace', 'type', 'class', 'enum', 'interface', 'struct', 'typeParameter', 'parameter', 'variable', 'property', 'enumMember', 'event', 'function', 'method', 'macro', 'keyword', 'modifier', 'comment', 'string', 'number', 'regexp', 'operator', 'decorator' },
    --       tokenModifiers = { 'declaration', 'definition', 'readonly', 'static', 'deprecated', 'abstract', 'async', 'modification', 'documentation', 'defaultLibrary'}
    --     }
    --   }
    -- end
end


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

-- Wrap capabilities with COQ
local coq_capabilities = coq.lsp_ensure_capabilities(capabilities)

-- lua_ls configuration with vim.lsp.config
vim.lsp.config("lua_ls", {
    on_attach = on_attach,
    capabilities = coq_capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.fn.expand "$VIMRUNTIME/lua",
                    vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                    vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/luv/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})

-- gopls configuration
vim.lsp.config("gopls", {
    on_attach = on_attach,
    capabilities = coq_capabilities,
    settings = {
        gopls = {
            semanticTokens = true,
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
                shadow = true,
                nilness = true,
                unusedwrite = true,
            },
            staticcheck = true,
            gofumpt = false,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
})

-- kotlin_lsp configuration (with explicit cmd for brew path)
vim.lsp.config("kotlin_lsp", {
    on_attach = on_attach,
    capabilities = coq_capabilities,
    cmd = { "kotlin-lsp", "--stdio" },
})

-- servers with default config
local servers = { "html", "cssls", "yamlls", "ts_ls", "pyright", "clangd", "tailwindcss" }

for _, server in ipairs(servers) do
    vim.lsp.config(server, {
        on_attach = on_attach,
        capabilities = coq_capabilities,
    })
end

-- Servers requiring explicit cmd
vim.lsp.config("buf_ls", {
    on_attach = on_attach,
    capabilities = coq_capabilities,
    cmd = { "buf", "lint", "breaking", "--path" },
})

vim.lsp.config("jdtls", {
    on_attach = on_attach,
    capabilities = coq_capabilities,
    cmd = { "jdtls" },
})

vim.lsp.config("nginx_language_server", {
    on_attach = on_attach,
    capabilities = coq_capabilities,
    cmd = { "nginx-language-server" },
})

-- Enable all configured LSP servers
vim.lsp.enable("gopls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("kotlin_lsp")
