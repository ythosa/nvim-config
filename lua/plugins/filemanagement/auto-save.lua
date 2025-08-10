return {
    "pocco81/auto-save.nvim",
    enabled = false,
    lazy = false,
    config = function()
        require("auto-save").setup {
            config = {
                trigger_events = { "BufLeave" },
            },
        }
    end,
}
