return {
    "princejoogie/dir-telescope.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    cmd = { "GrepInDirectory", "FileInDirectory" },
    keys = {
        { "<leader>fd", "<cmd>GrepInDirectory<CR>", desc = "search text in a selected directory" },
        { "<leader>pd", "<cmd>FileInDirectory<CR>", desc = "search files in a selected directory" },
    },
    opts = function()
        local opts = {
            hidden = true,
            no_ignore = true,
            show_preview = false,
        }

        if vim.fn.has "win32" == 0 and vim.fn.executable "fd" == 0 and vim.fn.executable "fdfind" == 0 then
            opts.find_command = function(config)
                -- find already includes ignored directories and has no no_ignore option.
                config.no_ignore = nil
                return { "find", ".", "-name", ".git", "-prune", "-o", "-type", "d", "-print" }
            end
        end

        return opts
    end,
}
