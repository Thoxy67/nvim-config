-- ============================================================================
-- RUBY LANGUAGE SUPPORT
-- lua/plugins/languages/ruby.lua
-- ============================================================================
-- Comprehensive Ruby development environment featuring:
-- - Multiple LSP servers (ruby_lsp/solargraph) for optimal coverage
-- - Advanced debugging with DAP integration
-- - Code formatting with rubocop/standardrb
-- - Testing support with neotest-rspec
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lsp = vim.g.lazyvim_ruby_lsp or "ruby_lsp"
local formatter = vim.g.lazyvim_ruby_formatter or "rubocop"

-- ==================== SHARED CONFIGURATION ====================
-- Common settings for all Ruby LSP servers
local root_markers = {
  "Gemfile",
}

local common_config = {
  on_attach = on_attach,
  filetypes = { "ruby" },
  root_markers = root_markers,
}

-- ==================== LSP SERVER CONFIGURATIONS ====================
-- Configure each Ruby LSP server with specific capabilities
local servers = {
  -- ruby_lsp: Shopify's Ruby LSP server
  ruby_lsp = {
    settings = {
      ruby_lsp = {
        -- ruby_lsp-specific settings can be added here
      },
    },
  },

  -- Solargraph: Ruby language server
  solargraph = {
    settings = {
      solargraph = {
        -- Solargraph-specific settings can be added here
      },
    },
  },

  -- Rubocop: Ruby linter and formatter as LSP
  rubocop = {
    settings = {
      rubocop = {
        -- Rubocop-specific settings can be added here
      },
    },
  },

  -- Standardrb: Ruby style guide, linter, and formatter
  standardrb = {
    settings = {
      standardrb = {
        -- standardrb-specific settings can be added here
      },
    },
  },
}

-- Enable the selected LSP server
if servers[lsp] then
  local final_config = vim.tbl_deep_extend("force", common_config, servers[lsp])
  vim.lsp.config[lsp] = final_config
end

-- Enable rubocop as LSP if it's the formatter and solargraph is not the main LSP
-- (to avoid duplicate diagnostics since Solargraph already calls Rubocop)
if formatter == "rubocop" and lsp ~= "solargraph" and servers.rubocop then
  local rubocop_config = vim.tbl_deep_extend("force", common_config, servers.rubocop)
  vim.lsp.config.rubocop = rubocop_config
  vim.lsp.enable { lsp, "rubocop" }
elseif formatter == "standardrb" and servers.standardrb then
  local standardrb_config = vim.tbl_deep_extend("force", common_config, servers.standardrb)
  vim.lsp.config.standardrb = standardrb_config
  vim.lsp.enable { lsp, "standardrb" }
else
  vim.lsp.enable { lsp }
end

return {
  -- Add packages (linting, formatting, debug adapter)
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "erb-formatter",
        "erb-lint",
      },
    },
  },
  -- Add syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "ruby" } },
  },
  -- Add formatting
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ruby = { formatter },
        eruby = { "erb_format" },
      },
    },
  },
  -- Add debugger
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "suketa/nvim-dap-ruby",
      config = function()
        require("dap-ruby").setup()
      end,
    },
  },
  -- Add testing support
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "olimorris/neotest-rspec",
    },
    opts = {
      adapters = {
        ["neotest-rspec"] = {
          -- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
          -- rspec_cmd = function()
          --   return vim.tbl_flatten({
          --     "bundle",
          --     "exec",
          --     "rspec",
          --   })
          -- end,
        },
      },
    },
  },
}
