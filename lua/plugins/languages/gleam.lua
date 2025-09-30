-- ============================================================================
-- GLEAM LANGUAGE SUPPORT
-- lua/plugins/languages/gleam.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

vim.lsp.config.gleam = {
  on_attach = on_attach,
  filetypes = { "gleam" },
  root_markers = { "gleam.toml" },
}

vim.lsp.enable { "gleam" }

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
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gleam = {
          on_attach = on_attach,
          filetypes = {
            "gleam",
          },
          root_markers = { "gleam.toml" },
        },
      },
    },
  },
  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        gleam = { "gleam" },
      },
    },
  },
}
