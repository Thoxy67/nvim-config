-- ============================================================================
-- C3 LANGUAGE SUPPORT
-- lua/plugins/languages/c3.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = lspconfig.util

-- Configure C3 Language Server (c3-lsp)
lspconfig.c3_lsp.setup {
  on_attach = on_attach,
  filetypes = { "c3", "c3i" },
  root_dir = util.root_pattern("project.json", "manifest.json", ".git"),
  settings = {
    c3_lsp = {},
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c3" } },
  },
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "c3-lsp",
      },
    },
  },
}
