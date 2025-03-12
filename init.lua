vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- style
vim.opt.colorcolumn = "120"

vim.api.nvim_set_keymap('i', '<Esc>', [[pumvisible() ? "\<C-e><Esc>" : "\<Esc>"]], { expr = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-c>', [[pumvisible() ? "\<C-e><C-c>" : "\<C-c>"]], { expr = true, silent = true })
vim.api.nvim_set_keymap('i', '<BS>', [[pumvisible() ? "\<C-e><BS>" : "\<BS>"]], { expr = true, silent = true })
vim.api.nvim_set_keymap(
  "i",
  "<CR>",
  [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]],
  { expr = true, silent = true }
)
vim.api.nvim_set_keymap('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<BS>"]], { expr = true, silent = true })

vim.lsp.inlay_hint.enable(true) -- enabling inlay hints for lsp's

-- code folding: zR (open all), zM (close all), za (toggle under cursor), zk & zj (nav between folds)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 5
vim.opt.foldnestmax = 6

