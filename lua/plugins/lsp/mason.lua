dofile(vim.g.base46_cache .. "mason")

local config = {
    PATH = "skip",

    ui = {
        icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ",
        },
    },

    max_concurrent_installers = 10,
}

return {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = function()
        return config
    end,
}
