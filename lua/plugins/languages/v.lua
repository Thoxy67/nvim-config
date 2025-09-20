-- ============================================================================
-- V LANGUAGE SUPPORT
-- lua/plugins/languages/v.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- Configure V Language Analyzer
vim.lsp.config.v_analyzer = {
  -- on_attach = on_attach,
  cmd = { vim.fn.expand "~" .. "/.config/v-analyzer/bin/v-analyzer" },
  filetypes = { "v" },
  root_markers = { "v.mod", ".git" },
  mason = false, -- Not available through Mason
  settings = {
    mason = false,
    -- v-analyzer specific settings can be added here
  },
}

return {
  -- Treesitter support for V
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "v" } },
  },

  -- LSP configuration override
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        v_analyzer = {
          mason = false, -- v-analyzer is not available through Mason
        },
      },
    },
  },
}
