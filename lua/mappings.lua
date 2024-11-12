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
end, { desc = "Telescope search files in selected tree node" })
map("n", "<leader>fwt", function()
  local api = require('nvim-tree.api')
  local node = api.tree.get_node_under_cursor()
  local path = node.absolute_path
  require('telescope.builtin').live_grep {
      prompt_title = "Search in " .. path,
      cwd = path,
  }
end, { desc = "Telescope search strings in selected tree node" })

map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Dap add breakpoint line" })
map("n", "<leader>dus", function()
  local widgets = require('dap.ui.widgets');
  local sidebar = widgets.sidebar(widgets.scopes);
  sidebar.open();
end, { desc = "Dap debugging sidebar" })

map("n", "<leader>dgl", function()
  require('dap-go').debug_last()
end, { desc = "DapGo debug last test" })
map("n", "<leader>dgt", function()
  require('dap-go').debug_last()
end, { desc = "DapGo debug test" })

map('n', '<leader>bc', ':bufdo if &filetype != "iletype" | bdelete | endif<CR>', { noremap = true, silent = true })
