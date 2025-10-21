-- ============================================================================
-- GLEAM LANGUAGE SUPPORT
-- lua/plugins/languages/gleam.lua
-- ============================================================================
-- Comprehensive Gleam development environment featuring:
-- - Gleam LSP for type checking, completion, and diagnostics
-- - Official gleam.vim plugin for syntax highlighting
-- - Treesitter support for advanced syntax highlighting
-- - Built-in Gleam formatter (gleam format)
-- - Project detection via gleam.toml
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== GLEAM LSP CONFIGURATION ====================
-- Gleam's built-in language server provides type-aware features
vim.lsp.config.gleam = {
  on_attach = on_attach,
  filetypes = { "gleam" },
  root_markers = { "gleam.toml" }, -- Gleam project configuration file
}

vim.lsp.enable { "gleam" }

return {
  -- ==================== GLEAM.VIM PLUGIN ====================
  -- Official Gleam syntax plugin for file detection and basic highlighting
  {
    "gleam-lang/gleam.vim",
    ft = "gleam", -- Only load for Gleam files (.gleam)
  },

  -- ==================== TREESITTER SUPPORT ====================
  -- Enhanced syntax highlighting for Gleam
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "gleam" } }, -- Gleam parser
  },

  -- ==================== LSP SERVER CONFIGURATION ====================
  -- Additional LSP configuration (redundant but ensures compatibility)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gleam = {
          on_attach = on_attach,
          filetypes = { "gleam" },
          root_markers = { "gleam.toml" }, -- Detect Gleam projects
        },
      },
    },
  },

  -- ==================== FORMATTING CONFIGURATION ====================
  -- Use Gleam's built-in formatter (gleam format)
  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        gleam = { "gleam" }, -- Gleam formatter (part of Gleam toolchain)
      },
    },
  },
}
