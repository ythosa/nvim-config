local config = {
    ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc", "go", "python" },
    sync_install = true,

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- The main branch uses a different configuration API.
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
        return config
    end,
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
