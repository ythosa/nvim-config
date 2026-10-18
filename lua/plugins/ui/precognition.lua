return {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = {
        startVisible = false,
        targetedMotionHints = { enabled = false },
    },
    keys = {
        {
            "<leader>p",
            function()
                require("precognition").toggle()
            end,
            desc = "precognition",
        },
    },
}
