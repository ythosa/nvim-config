local M = {}

M.setup = function()
  require('treesitter-context').setup{
    enable = true,
    max_lines = 0,
  }
end

return M
