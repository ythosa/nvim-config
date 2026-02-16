pcall(function()
    
    
end)

local config = {
    ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc", "go" },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
}

return {
    "nvim-treesitter/nvim-treesitter",
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
