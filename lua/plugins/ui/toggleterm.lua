return {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,
    config = function()
        require("toggleterm").setup {
            size = 20,
            open_mapping = [[<c-\>]],
            shade_terminals = true,
            direction = "float",
            float_opts = {
                border = "rounded", -- Стиль границы (как в Telescope)
                winblend = 10, -- Прозрачность
                width = function()
                    return math.min(800, math.floor(vim.o.columns * 0.7))
                end,
                height = function()
                    return math.min(600, math.floor(vim.o.lines * 0.7))
                end,
            },
            highlights = {
                FloatBorder = {
                    guifg = "#89B4FA", -- Цвет границы (как в вашей теме)
                },
            },
        }

        require("toggleterm.terminal").Terminal:new {
            on_open = function(term)
                vim.cmd "startinsert!"
                vim.api.nvim_buf_set_name(term.bufnr, "Terminal #" .. term.id)
                vim.opt_local.statuscolumn = ""
            end,
            -- Иконка в виде 
            float_opts = {
                title = "  Terminal ",
                title_pos = "center",
            },
        }
    end,
}
