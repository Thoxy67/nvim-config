-- ============================================================================
-- PYTHON LANGUAGE SUPPORT
-- lua/plugins/languages/python.lua
-- ============================================================================

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = lspconfig.util

-- Shared configuration
local root_dir = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json" }
local common_config = {
  on_attach = on_attach,
  filetypes = { "python" },
  root_dir = util.root_pattern(root_dir),
}

-- Setup all Python LSP servers
local servers = {
  ruff = {
    on_attach = function(client, _)
      -- prefer pyright's hover provider
      client.server_capabilities.hoverProvider = false
    end,
    settings = {
      ruff = {
        cmd_env = { RUFF_TRACE = "messages" },
        init_options = {
          settings = {
            logLevel = "error",
          },
        },
      },
    },
  },
  pyright = {
    settings = {
      pyright = {},
    },
  },
  basedpyright = {
    settings = {
      basedpyright = {},
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
    opts = { ensure_installed = { "ninja", "rst" } },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
      -- stylua: ignore
      keys = {
        { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
        { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
      },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp", -- Use this branch for the new version
    cmd = "VenvSelect",
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
    --  Call config for python files and load the cached venv automatically
    ft = "python",
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },
}
