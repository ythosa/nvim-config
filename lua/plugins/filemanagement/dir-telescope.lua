return {
    "princejoogie/dir-telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    event = "BufRead",
    config = function()
        require("dir-telescope").setup {
            hidden = true,
            no_ignore = true,
            show_preview = true,
        }
        vim.keymap.set("n", "<leader>fd", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<leader>pd", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })
    end,
}
