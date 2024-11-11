require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>fft", function() 
  local api = require('nvim-tree.api')
  local node = api.tree.get_node_under_cursor()
  local path = node.absolute_path
  require('telescope.builtin').find_files {
      prompt_title = "Search in " .. path,
      cwd = path,
  }
end, { desc = "Search files in selected tree node" })
map("n", "<leader>fwt", function() 
  local api = require('nvim-tree.api')
  local node = api.tree.get_node_under_cursor()
  local path = node.absolute_path
  require('telescope.builtin').live_grep {
      prompt_title = "Search in " .. path,
      cwd = path,
  }
end, { desc = "Search strings in selected tree node" })

