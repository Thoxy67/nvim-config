-- ============================================================================
-- NIX LANGUAGE SUPPORT
-- lua/plugins/languages/nix.lua
-- ============================================================================
-- Comprehensive Nix development environment featuring:
-- - nil_ls LSP server for Nix language support
-- - Code formatting with nixfmt
-- - Treesitter syntax highlighting
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== SHARED CONFIGURATION ====================
-- Common settings for Nix LSP server
local root_markers = {
  "flake.nix",
}

local common_config = {
  on_attach = on_attach,
  filetypes = { "nix" },
  root_markers = root_markers,
}

-- ==================== LSP SERVER CONFIGURATIONS ====================
-- Configure Nix LSP server
vim.lsp.config.nil_ls = vim.tbl_deep_extend("force", common_config, {
  settings = {
    nil_ls = {
      -- nil_ls-specific settings can be added here
    },
  },
})

vim.lsp.enable { "nil_ls" }

return {
  -- Add syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "nix" } },
  },
  -- Add formatting
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
      },
    },
  },
  -- Add linting
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.nix = { "statix" }
      return opts
    end,
  },
}
