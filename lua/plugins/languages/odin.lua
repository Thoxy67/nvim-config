-- ============================================================================
-- ODIN LANGUAGE SUPPORT
-- lua/plugins/languages/odin.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = lspconfig.util

-- Configure Odin Language Server (ols)
lspconfig.ols.setup {
  on_attach = on_attach,
  filetypes = { "odin" },
  root_dir = util.root_pattern("ols.json", ".git", "*.odin"),
  settings = {
    ols = {},
  },
}

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
