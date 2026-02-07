return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo" },
    opts = function()
      return require "configs.conform"
    end,
  },

  -- Mason (instalador de LSPs/DAPs/formatters)
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  -- Ponte Mason -> lspconfig (faz lspconfig achar os binários do Mason)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      automatic_installation = false,
    },
  },

  -- LSPConfig
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    --config = function()
    --require "configs.lspconfig"
    --end,
  },
}
