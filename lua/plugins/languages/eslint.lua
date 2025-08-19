-- ============================================================================
-- Typescipt / Javascipt LANGUAGE SUPPORT
-- lua/plugins/languages/typescript.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = lspconfig.util

lspconfig.eslint.setup {
  on_attach = on_attach,
  enabled = false,
  settings = {
    workingDirectories = { mode = "auto" },
    format = true,
    eslint = {},
  },
}

return {}
