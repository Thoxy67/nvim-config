-- ============================================================================
-- Shell script LANGUAGE SUPPORT
-- lua/plugins/languages/shell.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = lspconfig.util

lspconfig.bashls.setup {
  on_attach = on_attach,
  filetypes = { "zsh", "sh" },
  settings = {
    bashls = {},
  },
}

lspconfig.fish_lsp.setup {
  on_attach = on_attach,
  filetypes = { "fish" },
  settings = {
    fish_lsp = {},
  },
}

lspconfig.nushell.setup {
  on_attach = on_attach,
  filetypes = { "nu" },
  settings = {
    nushell = {},
  },
}

return {
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "fish-lsp",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "fish", "bash", "nu" } },
  },
}
