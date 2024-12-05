local M = {}

function M.setup()
  require("nvim-tree").setup({
    view = {
      width = 50,
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
      update_root = false,
      ignore_list = {},
    }
  })
end

return M
