return {
    "tzachar/local-highlight.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        hlgroup = "LocalHighlight",
        highlight = true,
        toggle_event = { { "BufRead", "BufNew" }, { "BufWrite", "BufWritePost" } },
        clear_highlight = true,
        nvimCTX = false,
        animate = { enabled = false },
    }
}
