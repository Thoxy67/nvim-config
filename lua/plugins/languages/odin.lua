-- ============================================================================
-- ODIN LANGUAGE SUPPORT
-- lua/plugins/languages/odin.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- Configure Odin Language Server (ols)
vim.lsp.config.ols = {
  on_attach = on_attach,
  filetypes = { "odin" },
  root_markers = { "ols.json", ".git", "*.odin" },
  settings = {
    ols = {},
  },
}

vim.lsp.enable { "ols" }

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "odin" } },
  },
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "ols",
      },
    },
  },
}
