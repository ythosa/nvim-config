return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
        -- coq for autocompletion
        { "ms-jpq/coq_nvim", branch = "coq" }, -- main one
        { "ms-jpq/coq.artifacts", branch = "artifacts" }, -- for snippets
        { "ms-jpq/coq.thirdparty", branch = "3p" }, -- third party sources -- See https://github.com/ms-jpq/coq.thirdparty
        -- - shell repl
        -- - nvim lua api
        -- - scientific calculator
        -- - comment banner
        -- - etc

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
                    always_on_top = { "gopls", "lua_ls" },
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
