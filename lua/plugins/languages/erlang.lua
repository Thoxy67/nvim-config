-- ============================================================================
-- ERLANG LANGUAGE SUPPORT
-- lua/plugins/languages/erlang.lua
-- ============================================================================
-- Erlang development environment featuring:
-- - erlangls language server for code intelligence
-- - Support for rebar3 and erlang.mk build systems
-- - Treesitter syntax highlighting
-- - Completion, diagnostics, and go-to-definition
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== ERLANG LSP CONFIGURATION ====================
-- erlangls provides comprehensive language server features for Erlang
vim.lsp.config.erlangls = {
  on_attach = on_attach,
  filetypes = { "erlang" },
  root_markers = {
    "rebar.config",  -- rebar3 build tool configuration
    "erlang.mk",     -- erlang.mk build system
  },
}

vim.lsp.enable { "erlangls" }

return {
  -- ==================== LSP SERVER CONFIGURATION ====================
  -- Erlang language server for code intelligence
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        erlangls = {}, -- Erlang LS provides completion, diagnostics, and navigation
      },
    },
  },

  -- ==================== TREESITTER SUPPORT ====================
  -- Syntax highlighting for Erlang
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "erlang" } }, -- Erlang parser
  },
}
