return {
    "ray-x/go.nvim",
    dependencies = {
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
        "theHamsta/nvim-dap-virtual-text",
    },
    opts = {},
    ft = { "go", "gomod", "gowork", "gotmpl" },
}
