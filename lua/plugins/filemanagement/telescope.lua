return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    opts = function()
        -- Clone the default Telescope configuration
        local telescope_config = require "telescope.config"
        local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

        -- I want to search in hidden/dot files.
        table.insert(vimgrep_arguments, "--hidden")
        -- I don't want to search in the `.git` directory.
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        return {
            defaults = {
                vimgrep_arguments = vimgrep_arguments,
                preview = { hide_on_startup = true },
                file_ignore_patterns = {},
                prompt_prefix = "   ",
                selection_caret = " ",
                entry_prefix = " ",
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                    },
                    width = 0.87,
                    height = 0.80,
                },
                mappings = {
                    n = { ["q"] = require("telescope.actions").close },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    find_command = { "rg", "--files", "--color", "never", "--glob", "!**/.git/*" },
                },
            },
        }
    end,
}
