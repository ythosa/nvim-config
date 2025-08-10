dofile(vim.g.base46_cache .. "git")

local config = {
    signs = {
        delete = { text = "󰍵" },
        changedelete = { text = "󱕖" },
    },
}

return {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
        return config
    end,
}
