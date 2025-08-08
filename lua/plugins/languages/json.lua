local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

-- Zig ( https://ziglang.org/ )
lspconfig.jsonls.setup {
  on_attach = on_attach,
  on_new_config = function(new_config)
    new_config.settings.json.schemas = new_config.settings.json.schemas or {}
    vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
  end,
  cmd = { "/usr/bin/zls" },
  filetypes = { "json", "jsonc", "json5" },
  root_dir = util.root_pattern "*.json",
  settings = {
    json = {
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "json5" } },
  },
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },
}
