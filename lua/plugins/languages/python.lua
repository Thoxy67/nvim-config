-- ============================================================================
-- PYTHON LANGUAGE SUPPORT
-- lua/plugins/languages/python.lua
-- ============================================================================
-- Comprehensive Python development environment featuring:
-- - Multiple LSP servers (Pyright/BasedPyright + Ruff) for optimal coverage
-- - Advanced debugging with DAP and neotest integration
-- - Virtual environment management with venv-selector
-- - Code formatting, linting, and type checking capabilities
-- ============================================================================

-- ==================== LSP SERVER SELECTION ====================
-- Configure which Python LSP servers to use
vim.g.lazyvim_python_lsp = "pyright"    -- Main LSP: "pyright" or "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"      -- Linter/Formatter: "ruff" or "ruff_lsp"

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== SHARED CONFIGURATION ====================
-- Common settings for all Python LSP servers
local root_markers = {
  "pyproject.toml",      -- Modern Python projects
  "setup.py",            -- Traditional setuptools
  "setup.cfg",           -- Setup configuration
  "requirements.txt",    -- Pip requirements
  "Pipfile",             -- Pipenv projects
  "pyrightconfig.json"   -- Pyright configuration
}

local common_config = {
  on_attach = on_attach,
  filetypes = { "python" },
  root_markers = root_markers,
}

-- ==================== LSP SERVER CONFIGURATIONS ====================
-- Configure each Python LSP server with specific capabilities
local servers = {
  -- Ruff: Fast Python linter and formatter
  ruff = {
    on_attach = function(client, _)
      -- Disable hover to prefer Pyright's more detailed hover information
      client.server_capabilities.hoverProvider = false
    end,
    settings = {
      ruff = {
        cmd_env = { RUFF_TRACE = "messages" },  -- Enable tracing for debugging
        init_options = {
          settings = {
            logLevel = "error",  -- Reduce noise in logs
          },
        },
      },
    },
  },

  -- Pyright: Microsoft's Python language server
  pyright = {
    settings = {
      pyright = {
        -- Pyright-specific settings can be added here
        -- autoImportCompletion = true,
        -- useLibraryCodeForTypes = true,
      },
    },
  },

  -- BasedPyright: Community fork of Pyright with additional features
  basedpyright = {
    settings = {
      basedpyright = {
        -- BasedPyright-specific settings can be added here
        -- analysis = { typeCheckingMode = "basic" },
      },
    },
  },
}

for server, config in pairs(servers) do
  local final_config = vim.tbl_deep_extend("force", common_config, config)
  vim.lsp.config[server] = final_config
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "ninja", "rst" } },
  },
  {

    "joshzcold/python.nvim",
    ft = { "python" },
    dependencies = {
      { "mfussenegger/nvim-dap" },
      { "mfussenegger/nvim-dap-python" },
      { "neovim/nvim-lspconfig" },
      { "L3MON4D3/LuaSnip" },
      { "nvim-neotest/neotest" },
      { "nvim-neotest/neotest-python" },
    },
    ---@type python.Config
    opts = { ---@diagnostic disable-line: missing-fields`
      python_lua_snippets = true,
    },
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
    cmd = "VenvSelect",
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
    --  Call config for Python files and load the cached venv automatically
    ft = "python",
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },
}
