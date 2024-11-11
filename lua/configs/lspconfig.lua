local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

nvlsp.defaults() -- loads nvchad's defaults

local ooo = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)
  vim.keymap.set("n", "gd", "<cmd> Telescope lsp_definitions <cr>", { buffer = bufnr })
  vim.keymap.set("n", "gr", "<cmd> Telescope lsp_references <cr>", { buffer = bufnr })
  vim.keymap.set("n", "gi", "<cmd> Telescope lsp_implementations <cr>", { buffer = bufnr })
end

-- lsps with default config
local servers = { "html", "cssls", "clangd" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = ooo,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig["gopls"].setup {
  on_attach = ooo,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  }
}

