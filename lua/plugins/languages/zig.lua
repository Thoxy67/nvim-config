local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

-- Zig ( https://ziglang.org/ )
lspconfig.zls.setup {
  on_attach = on_attach,
  cmd = { "/usr/bin/zls" },
  filetypes = { "zig", "zir", "zon" },
  root_dir = util.root_pattern("build.zig", "build.zon"),
  settings = {
    zls = {
      single_file_support = true,
      zig_lib_path = "/usr/lib/zig/lib",
      enable_snippets = true,
      warn_style = false,
      enable_semantic_tokens = true,
      operator_completions = true,
      -- zls specific settings
    },
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "zig" } },
  },
  {
    "lawrence-laz/neotest-zig",
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "lawrence-laz/neotest-zig",
    },
    opts = {
      adapters = {
        ["neotest-zig"] = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        zig = { "zigfmt" },
        zon = { "zigfmt" },
      },
    },
  },
}
