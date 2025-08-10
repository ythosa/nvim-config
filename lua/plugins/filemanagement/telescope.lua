dofile(vim.g.base46_cache .. "telescope")
pcall(function()
    dofile(vim.g.base46_cache .. "syntax")
    dofile(vim.g.base46_cache .. "treesitter")
end)

-- Clone the default Telescope configuration
local telescopeConfig = require "telescope.config"
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

local config = {
    defaults = {
        vimgrep_arguments = vimgrep_arguments,
        file_ignore_patterns = {},
        hidden = true,
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
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
    extensions_list = { "themes", "terms" },
    extensions = {},
}

return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
        return config
    end,
}
