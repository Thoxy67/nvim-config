-- ============================================================================
-- YAML LANGUAGE SUPPORT
-- lua/plugins/languages/yaml.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- Configure YAML Language Server with schema support
vim.lsp.config.yamlls = {
  on_attach = on_attach,
  before_init = function(_, new_config)
    new_config.settings.yaml.schemas =
      vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
  end,
  filetypes = { "yaml" },
  root_markers = { "*.yml", "*.yaml" },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      validate = true,
      schemaStore = {
        -- Must disable built-in schemaStore support to use
        -- schemas from SchemaStore.nvim plugin
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
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
        "yamlfmt", -- Import management
      },
    },
  },
  -- {
  --   "mason.nvim",
  --   opts = { ensure_installed = { "yaml-language-server" } },
  -- },
}
