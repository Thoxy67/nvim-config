-- ============================================================================
-- Docker LANGUAGE SUPPORT
-- lua/plugins/languages/docker.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = lspconfig.util

lspconfig.dockerls.setup {
  on_attach = on_attach,
  filetypes = { "dockerfile" },
  root_dir = util.root_pattern(
    "Dockerfile",
    "docker-compose.yml",
    "compose.yml",
    "docker-compose.yaml",
    "compose.yaml"
  ),
  settings = {
    dockerls = {},
  },
}

lspconfig.docker_compose_language_service.setup {
  on_attach = on_attach,
  filetypes = { "dockerfile" },
  root_dir = util.root_pattern(
    "Dockerfile",
    "docker-compose.yml",
    "compose.yml",
    "docker-compose.yaml",
    "compose.yaml"
  ),
  settings = {
    docker_compose_language_service = {},
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "dockerfile" } },
  },
  {
    "mason.nvim",
    opts = { ensure_installed = { "hadolint" } },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require "null-ls"
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.hadolint,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        dockerfile = { "hadolint" },
      },
    },
  },
}
