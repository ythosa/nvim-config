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
            auto_start = true,
            keymap = {
                recommended = false,
                jump_to_mark = "<C-]>",
                bigger_preview = "<C-l>",
            },
            clients = {
                lsp = {
                    resolve_timeout = 1,
                },
            },
            display = {
                pum = {
                    fast_close = true,
                },
                preview = {
                    positions = {
                        east = 3,
                        south = 4,
                    },
                },
            },
        }
    end,
    config = function()
        require "plugins.lsp.configs.lspconfig"
    end,
}
