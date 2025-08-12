-- ============================================================================
-- GLEAM LANGUAGE SUPPORT
-- lua/plugins/languages/gleam.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

-- Configure V Language Analyzer
lspconfig.gleam.setup {
  on_attach = on_attach,
  filetypes = { "gleam" },
  root_dir = util.root_pattern "gleam.toml",
  settings = {},
}

return {
  {
    -- Gleam syntax highlighting and basic support
    "gleam-lang/gleam.vim",
    ft = "gleam", -- Only load for Gleam files
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "gleam" } },
  },
}
