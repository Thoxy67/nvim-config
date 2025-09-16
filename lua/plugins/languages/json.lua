-- ============================================================================
-- JSON LANGUAGE SUPPORT (OPTIONAL - COMMENTED OUT IN INIT)
-- lua/plugins/languages/json.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = lspconfig.util

-- Configure JSON Language Server with schema support
lspconfig.jsonls.setup {
  on_attach = on_attach,
  before_init = function(_, new_config)
    new_config.settings.json.schemas = new_config.settings.json.schemas or {}
    vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
  end,
  filetypes = { "json", "jsonc", "json5" },
  root_dir = util.root_pattern "*.json",
  settings = {
    json = {
      -- schemas = require("schemastore").json.schemas(),
      format = {
        enable = true, -- Enable JSON formatting
      },
      validate = {
        enable = true, -- Enable JSON validation
      },
    },
  },
}

return {
  -- Treesitter support for JSON variants
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "json5" } },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "b0o/SchemaStore.nvim",
      },
    },
  },
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "biome", -- Import management
      },
    },
  },
}
