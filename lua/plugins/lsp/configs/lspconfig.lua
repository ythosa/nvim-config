require "coq"

local map = vim.keymap.set

local on_attach = function(args)
    local bufnr = args.buf

    local function opts(desc)
        return { buffer = bufnr, desc = "LSP " .. desc }
    end

    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

    map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
    vim.keymap.set("n", "<Leader>ra", "<cmd>lua vim.lsp.buf.rename()<cr>", { buffer = bufnr })

    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts "Go to definition")
    map("n", "gr", "<cmd>Telescope lsp_references<CR>", opts "Show references")
    map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts "Go to implementation")

    -- vim virtual text diagnostics toggle
    vim.keymap.set("n", "<leader>tdd", function()
        vim.diagnostic.config {
            virtual_lines = not vim.diagnostic.config().virtual_lines,
            virtual_text = not vim.diagnostic.config().virtual_text,
        }
    end, { desc = "toggle diagnostic" })
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_mappings", { clear = true }),
    callback = on_attach,
})

vim.lsp.config("*", {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
})

-- lua_ls configuration with vim.lsp.config
vim.lsp.config("lua_ls", {
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
    settings = {
        gopls = {
            matcher = "CaseInsensitive",
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
    cmd = { "kotlin-lsp", "--stdio" },
})

vim.lsp.config("clangd", {
    cmd = { "clangd", "--log=error" },
    before_init = function(params)
        -- clangd negotiates position encodings through the standard LSP capability.
        params.capabilities.offsetEncoding = nil
    end,
})

local servers = {
    gopls = "gopls",
    lua_ls = "lua-language-server",
    kotlin_lsp = "kotlin-lsp",
    html = "vscode-html-language-server",
    cssls = "vscode-css-language-server",
    yamlls = "yaml-language-server",
    ts_ls = "typescript-language-server",
    pyright = "pyright-langserver",
    clangd = "clangd",
    tailwindcss = "tailwindcss-language-server",
    buf_ls = "buf",
    jdtls = "jdtls",
    nginx_language_server = "nginx-language-server",
}

for server, command in pairs(servers) do
    if vim.fn.executable(command) == 1 then
        vim.lsp.enable(server)
    end
end
