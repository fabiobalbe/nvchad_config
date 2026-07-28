-- Load NvChad defaults (lua_ls + keymaps + diagnostics)
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- Servers installed via Mason
local servers = {
  "html", -- HTML
  "cssls", -- CSS
  "ts_ls", -- JavaScript / TypeScript
  "pyright", -- Python
  "intelephense", -- PHP
  "jinja_lsp", -- Jinja (kept from your config)
  -- lua_ls is already enabled by nvchad defaults()
}

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
  vim.lsp.enable(lsp)
end
