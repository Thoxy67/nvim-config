-- ============================================================================
-- TYPST LANGUAGE SUPPORT
-- lua/plugins/languages/typst.lua
-- ============================================================================
-- Comprehensive Typst document preparation environment featuring:
-- - Tinymist LSP for language intelligence and diagnostics
-- - Live preview with typst-preview.nvim
-- - Typstyle formatting support
-- - Treesitter syntax highlighting
-- - Comment syntax configuration
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== TINYMIST LSP CONFIGURATION ====================
-- Tinymist is the official language server for Typst
vim.lsp.config.tinymist = {
  on_attach = on_attach,
  filetypes = { "typst" },
  single_file_support = true, -- Enable LSP for single .typ files
  settings = {
    formatterMode = "typstyle", -- Use typstyle formatter
  },
}

vim.lsp.enable { "tinymist" }

return {
  -- ==================== TREESITTER SUPPORT ====================
  -- Syntax highlighting for Typst documents
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "typst" }, -- Typst parser for syntax highlighting
    },
  },

  -- ==================== LSP SERVER CONFIGURATION ====================
  -- Additional LSP configuration (redundant but ensures compatibility)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {
          single_file_support = true, -- Fixes LSP attachment in non-Git directories
          settings = {
            formatterMode = "typstyle", -- Use typstyle for formatting
          },
        },
      },
    },
  },

  -- ==================== FORMATTING CONFIGURATION ====================
  -- Typstyle formatter for Typst documents
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        typst = { "typstyle", lsp_format = "prefer" }, -- Use typstyle with LSP fallback
      },
    },
  },

  -- ==================== LIVE PREVIEW ====================
  -- Real-time preview of Typst documents while editing
  {
    "chomosuke/typst-preview.nvim",
    cmd = { "TypstPreview", "TypstPreviewToggle", "TypstPreviewUpdate" },
    opts = {
      dependencies_bin = {
        tinymist = "tinymist", -- Use tinymist for preview functionality
      },
    },
  },

  -- ==================== COMMENT CONFIGURATION ====================
  -- Define comment syntax for Typst files
  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        typst = { "// %s", "/* %s */" }, -- Line and block comment styles
      },
    },
  },
}
