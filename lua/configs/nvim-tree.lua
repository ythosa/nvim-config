local M = {}

function M.setup()
  require("nvim-tree").setup({
    view = {
      width = 50,
    },
  })
end

return M
