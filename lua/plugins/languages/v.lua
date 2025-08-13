-- ============================================================================
-- V LANGUAGE SUPPORT
-- lua/plugins/languages/v.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = lspconfig.util

-- Configure V Language Analyzer
lspconfig.v_analyzer.setup {
  on_attach = on_attach,
  cmd = { vim.fn.expand "~" .. "/.config/v-analyzer/bin/v-analyzer" },
  filetypes = { "v" },
  root_dir = util.root_pattern("v.mod", ".git"),
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
