return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        map_cr = false,
        map_bs = false,
    },
    config = function(_, opts)
        local autopairs = require "nvim-autopairs"
        autopairs.setup(opts)

        vim.keymap.set("i", "<CR>", function()
            if vim.fn.pumvisible() == 1 then
                if vim.fn.complete_info({ "selected" }).selected >= 0 then
                    return vim.keycode "<C-y>"
                end

                return vim.keycode "<C-e>" .. autopairs.autopairs_cr()
            end

            return autopairs.autopairs_cr()
        end, { expr = true, replace_keycodes = false, desc = "accept completion or insert paired newline" })

        vim.keymap.set("i", "<BS>", function()
            local backspace = autopairs.autopairs_bs()
            if vim.fn.pumvisible() == 1 then
                return vim.keycode "<C-e>" .. backspace
            end

            return backspace
        end, { expr = true, replace_keycodes = false, desc = "dismiss completion and delete paired characters" })
    end,
}
