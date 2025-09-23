-- ============================================================================
-- ZIG LANGUAGE SUPPORT
-- lua/plugins/languages/zig.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- Configure Zig Language Server (ZLS)
vim.lsp.config.zls = {
  on_attach = on_attach,
  cmd = { "/usr/bin/zls" }, -- Path to ZLS binary
  filetypes = { "zig", "zir", "zon" }, -- Zig file types
  root_markers = { "build.zig", "build.zon" },
  settings = {
    zls = {
      single_file_support = true, -- Support single files
      zig_lib_path = "/usr/lib/zig/lib", -- Path to Zig standard library
      enable_snippets = true, -- Enable code snippets
      warn_style = false, -- Disable style warnings
      enable_semantic_tokens = true, -- Enable semantic highlighting
      operator_completions = true, -- Complete operators
    },
  },
}

vim.lsp.enable { "zls" }

return {
  -- Treesitter support for Zig
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "zig" } },
  },

  -- Testing with neotest
  {
    "nvim-neotest/neotest",
    optional = false,
    dependencies = {
      "lawrence-laz/neotest-zig",
    },
    opts = {
      adapters = {
        ["neotest-zig"] = {}, -- Zig test adapter
      },
    },
  },

  -- Formatting configuration
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        zig = { "zigfmt" }, -- Format Zig files
        zon = { "zigfmt" }, -- Format Zig object notation files
      },
    },
  },
}
