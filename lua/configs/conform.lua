local M = {}

M.formatters_by_ft = {
  lua = { "stylua" },
  python = { "isort", "black" },
}

M.format_on_save = {
  timeout_ms = 2000,
  lsp_fallback = false,
}

return M
