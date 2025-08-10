return {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("treesitter-context").setup {
            enable = true,
            max_lines = 0,
        }
    end,
}
