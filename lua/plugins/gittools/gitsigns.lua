local config = {
    signs = {
        delete = { text = "󰍵" },
        changedelete = { text = "󱕖" },
    },
}

return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
        return config
    end,
}
