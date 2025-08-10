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
    },

    format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
    },
}

return {
    "stevearc/conform.nvim",
    opts = options,
}
