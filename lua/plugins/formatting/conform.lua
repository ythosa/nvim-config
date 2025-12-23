local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        ts = { "prettier" },
        js = { "prettier" },
        go = { "goimports-reviser", "gofumpt" },
        sql = { "sqlfmt" },
        cpp = { "clang-format" },
        python = { "black" },
    },

    format_on_save = {
        timeout_ms = 5000,
        lsp_fallback = true,
    },

    formatters = {
        black = {
            prepend_args = { "--fast" },
        },
    },
}

return {
    "stevearc/conform.nvim",
    opts = options,
}
