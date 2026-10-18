return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- coq for autocompletion
        { "ms-jpq/coq_nvim", branch = "coq" }, -- main one
        { "ms-jpq/coq.artifacts", branch = "artifacts" }, -- for snippets
        -- list of available classes and methods
        {
            "SmiteshP/nvim-navbuddy",
            dependencies = {
                "SmiteshP/nvim-navic",
                "MunifTanjim/nui.nvim",
            },
            opts = { lsp = { auto_attach = true } },
        },
    },
    init = function()
        vim.g.coq_settings = {
            completion = {
                skip_after = { " ", "\t", "{", "}", "[", "]" },
            },
            keymap = {
                recommended = false,
                bigger_preview = false,
            },
            clients = {
                buffers = { same_filetype = true },
                lsp = {
                    always_on_top = { "gopls", "lua_ls", "clangd" },
                    resolve_timeout = 1,
                },
                registers = { enabled = false },
                tags = { enabled = false },
                third_party = { enabled = false },
                tmux = { enabled = false },
                tree_sitter = { enabled = false },
            },
            display = {
                preview = {
                    enabled = false,
                },
            },
        }
    end,
    config = function()
        require "plugins.lsp.configs.lspconfig"
    end,
}
