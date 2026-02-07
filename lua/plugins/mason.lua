return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = false,
      automatic_enable = false, -- 👈 ESSA LINHA resolve duplicação
    },
  },
}
