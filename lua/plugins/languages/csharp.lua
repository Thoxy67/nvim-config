-- ============================================================================
-- C# LANGUAGE SUPPORT
-- lua/plugins/languages/csharp.lua
-- ============================================================================
-- Comprehensive C# development environment featuring:
-- - OmniSharp LSP server with extended functionality
-- - Advanced debugging with DAP integration
-- - Code formatting with csharpier
-- - Testing support with neotest-dotnet
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== SHARED CONFIGURATION ====================
-- Common settings for OmniSharp LSP server
local root_markers = {
  "*.sln",
  "*.csproj",
  "omnisharp.json",
  "function.json",
}

local common_config = {
  on_attach = on_attach,
  filetypes = { "cs", "vb" },
  root_markers = root_markers,
}

-- ==================== LSP SERVER CONFIGURATIONS ====================
-- Configure OmniSharp LSP server with extended functionality
vim.lsp.config.omnisharp = vim.tbl_deep_extend("force", common_config, {
  handlers = {
    ["textDocument/definition"] = function(...)
      return require("omnisharp_extended").handler(...)
    end,
  },
  settings = {
    omnisharp = {
      enable_roslyn_analyzers = true,
      organize_imports_on_format = true,
      enable_import_completion = true,
    },
  },
})

vim.lsp.enable { "omnisharp" }

return {
  -- Add OmniSharp extended LSP functionality
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    lazy = true,
  },
  -- Add packages (formatting, debug adapter)
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "csharpier",
        "netcoredbg",
      },
    },
  },
  -- Add syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c_sharp" } },
  },
  -- Add formatting
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
        },
      },
    },
  },
  -- Add formatting via none-ls
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require "null-ls"
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.csharpier,
      })
    end,
  },
  -- Add debugger
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require "dap"
      if not dap.adapters["netcoredbg"] then
        dap.adapters["netcoredbg"] = {
          type = "executable",
          command = vim.fn.exepath "netcoredbg",
          args = { "--interpreter=vscode" },
          options = {
            detached = false,
          },
        }
      end
      for _, lang in ipairs { "cs", "fsharp", "vb" } do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = "netcoredbg",
              name = "Launch file",
              request = "launch",
              program = function()
                return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
              end,
              cwd = "${workspaceFolder}",
            },
          }
        end
      end
    end,
  },
  -- Add testing support
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "Issafalcon/neotest-dotnet",
    },
    opts = {
      adapters = {
        ["neotest-dotnet"] = {
          -- Here we can set options for neotest-dotnet
        },
      },
    },
  },
}
