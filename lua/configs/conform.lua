local M = {}

M.options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },

    -- Jinja / Django-style HTML templates
    htmldjango = { "djlint" },
  },

  formatters = {
    djlint = {
      command = "djlint",
      args = { "--reformat", "-" },
      stdin = true,
    },
  },

  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = false,
  },
}

return M.options
