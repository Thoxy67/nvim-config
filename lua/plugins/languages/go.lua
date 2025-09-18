-- ============================================================================
-- GO LANGUAGE SUPPORT
-- lua/plugins/languages/go.lua
-- ============================================================================

-- Configure gopls (Go Language Server)
vim.lsp.config.gopls = {
  on_attach = function(client, _)
    -- Enable semantic tokens if not already provided
    if not client.server_capabilities.semanticTokensProvider then
      local semantic = client.config.capabilities.textDocument.semanticTokens
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = {
          tokenTypes = semantic.tokenTypes,
          tokenModifiers = semantic.tokenModifiers,
        },
        range = true,
      }
    end
  end,
  filetypes = { "go", "gomod", "gowork", "gotmlp" },
  root_markers = { "go.work", "go.mod" },
  settings = {
    gopls = {
      gofumpt = true, -- Use gofumpt for formatting

      -- Code lenses configuration
      codelenses = {
        gc_details = false, -- Don't show GC details
        generate = true, -- Show generate commands
        regenerate_cgo = true, -- Show regenerate cgo
        run_govulncheck = true, -- Show vulnerability check
        test = true, -- Show test/benchmark commands
        tidy = true, -- Show go mod tidy
        upgrade_dependency = true, -- Show upgrade dependency
        vendor = true, -- Show vendor commands
      },

      -- Inlay hints configuration
      hints = {
        assignVariableTypes = true, -- Show variable type hints
        compositeLiteralFields = true, -- Show struct field hints
        compositeLiteralTypes = true, -- Show composite literal types
        constantValues = true, -- Show constant values
        functionTypeParameters = true, -- Show function type parameters
        parameterNames = true, -- Show parameter names
        rangeVariableTypes = true, -- Show range variable types
      },

      -- Static analysis configuration
      analyses = {
        nilness = true, -- Check for nil pointer dereferences
        unusedparams = true, -- Check for unused parameters
        unusedwrite = true, -- Check for unused writes
        useany = true, -- Suggest using 'any' instead of 'interface{}'
      },

      -- Additional settings
      usePlaceholders = true, -- Use placeholders in completions
      completeUnimported = true, -- Complete unimported packages
      staticcheck = true, -- Enable staticcheck analyzer
      directoryFilters = { -- Exclude directories from analysis
        "-.git",
        "-.vscode",
        "-.idea",
        "-.vscode-test",
        "-node_modules",
      },
      semanticTokens = true, -- Enable semantic tokens
    },
  },
}

return {
  {
    "ray-x/go.nvim",
    enabled = false,
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- lsp_keymaps = false,
      -- other options
    },
    config = function(lp, opts)
      require("go").setup(opts)
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- Treesitter support for Go
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "go", "gomod", "gowork", "gosum" },
    },
  },

  -- Mason tool installation for Go
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "goimports", -- Import management
        "gofumpt", -- Stricter gofmt
        "gomodifytags", -- Modify struct tags
        "impl", -- Generate method stubs
      },
    },
  },

  -- Formatting configuration
  {
    "stevearc/conform.nvim",
    optional = false,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" }, -- Format Go files
      },
    },
  },

  -- Debug adapter configuration
  {
    "mfussenegger/nvim-dap",
    optional = false,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "delve" } }, -- Go debugger
      },
      {
        "leoluz/nvim-dap-go", -- Go-specific DAP configuration
        opts = {},
      },
    },
  },

  -- Testing with neotest
  {
    "nvim-neotest/neotest",
    optional = false,
    dependencies = {
      "fredrikaverpil/neotest-golang", -- Go test adapter
    },
    opts = {
      adapters = {
        ["neotest-golang"] = {
          -- Configure Go test runner
          -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
          dap_go_enabled = true, -- Enable debugging support
        },
      },
    },
  },
}
