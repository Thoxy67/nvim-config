-- ============================================================================
-- Docker LANGUAGE SUPPORT
-- lua/plugins/languages/docker.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = lspconfig.util

-- Shared configuration
local docker_root_patterns = {
  "Dockerfile",
  "docker-compose.yml",
  "compose.yml",
  "docker-compose.yaml",
  "compose.yaml",
}

local common_config = {
  on_attach = on_attach,
  filetypes = { "dockerfile" },
  root_dir = util.root_pattern(docker_root_patterns),
}

-- Setup Docker LSP servers
local servers = {
  dockerls = {
    settings = {
      dockerls = {},
    },
  },
  docker_compose_language_service = {
    settings = {
      docker_compose_language_service = {},
    },
  },
}

for server, config in pairs(servers) do
  local final_config = vim.tbl_deep_extend("force", common_config, config)
  lspconfig[server].setup(final_config)
end

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
