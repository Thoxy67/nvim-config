-- ============================================================================
-- RUST LANGUAGE SUPPORT
-- lua/plugins/languages/rust.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- Diagnostic provider selection: 'rust-analyzer' or 'bacon-ls'
-- bacon-ls provides faster diagnostics but requires bacon to be installed
vim.g.lazyvim_rust_diagnostics = "bacon-ls"

local use_rust_analyzer_diagnostics = vim.g.lazyvim_rust_diagnostics == "rust-analyzer"

-- Configure bacon-ls for fast diagnostics (if selected)
if vim.g.lazyvim_rust_diagnostics == "bacon-ls" then
  vim.lsp.config.bacon_ls = {
    on_attach = function(client, bufnr)
      -- Disable all capabilities except diagnostics to avoid conflicts
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.completionProvider = false
      client.server_capabilities.signatureHelpProvider = false
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.referencesProvider = false
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      client.server_capabilities.renameProvider = false
      client.server_capabilities.codeActionProvider = false

      -- Call the original on_attach
      on_attach(client, bufnr)
    end,
    settings = {
      -- bacon-ls settings can be configured here
    },
  }
  vim.lsp.enable { "bacon_ls", "rust-analyzer" }
else
  vim.lsp.enable { "rust-analyzer" }
end

return {
  -- Cargo.toml enhancement with crate information
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = function(_, opts)
      local crates = require "crates"

      -- Keymap to update all crates
      vim.keymap.set("n", "<leader>cu", function()
        crates.upgrade_all_crates()
      end, { desc = "Update crates" })

      local options = {
        completion = {
          crates = {
            enabled = true, -- Enable crate name completion
          },
        },
        lsp = {
          enabled = true, -- Enable LSP features
          actions = true, -- Enable code actions
          completion = true, -- Enable completion
          hover = true, -- Enable hover information
        },
      }

      opts = vim.tbl_deep_extend("force", opts or {}, options)
      return opts
    end,
    config = function(_, opts)
      require("crates").setup(opts)
    end,
  },

  {
    "Aityz/cratesearch.nvim", -- provide `:CrateSearch [query]` command to search for crates
    cmd = "CrateSearch",
    opts = {},
    config = function(_, opts)
      require("cratesearch").setup(opts)
    end,
  },

  -- Treesitter support for Rust syntax
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "rust", "ron" }, -- Rust and RON (Rusty Object Notation)
    },
  },

  -- Advanced Rust tooling with rustaceanvim
  {
    "mrcjkb/rustaceanvim",
    -- version = "^6", -- Use stable version
    ft = { "rust" },
    config = function(_, opts)
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {},

        -- LSP server configuration
        server = {
          on_attach = on_attach,
          root_markers = { "Cargo.toml", "build.rs", ".git" },
          default_settings = {
            ["rust-analyzer"] = {
              -- Cargo configuration
              cargo = {
                allFeatures = true, -- Enable all Cargo features
                loadOutDirsFromCheck = true, -- Load out directories from check
                buildScripts = {
                  enable = true, -- Enable build script support
                },
              },

              -- Diagnostics configuration
              checkOnSave = use_rust_analyzer_diagnostics,
              diagnostics = {
                enable = use_rust_analyzer_diagnostics,
              },

              -- Disable signature help to avoid conflicts with bacon_ls
              signatureHelp = {
                enable = use_rust_analyzer_diagnostics,
              },

              -- Procedural macro support
              procMacro = {
                enable = true,
                ignored = {
                  -- Ignore problematic macros that cause issues
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },

              -- File exclusion for better performance
              files = {
                excludeDirs = {
                  ".direnv",
                  ".git",
                  ".github",
                  ".gitlab",
                  "bin",
                  "node_modules",
                  "target",
                  "venv",
                  ".venv",
                },
              },
            },
          },
        },

        -- Debug Adapter Protocol configuration
        dap = {},
      }

      -- Configure CodeLLDB debugger if available through Mason
      local mason_ok, mason_registry = pcall(require, "mason-registry")
      if mason_ok then
        local codelldb_ok, codelldb_pkg = pcall(mason_registry.get_package, "codelldb")
        if codelldb_ok and codelldb_pkg:is_installed() then
          local codelldb = vim.fn.exepath "codelldb"
          local codelldb_lib_ext = io.popen("uname"):read "*l" == "Linux" and ".so" or ".dylib"
          local library_path = vim.fn.expand("$MASON/opt/lldb/lib/liblldb" .. codelldb_lib_ext)

          opts.dap = {
            adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
          }
        end
      end

      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})

      -- Warn if rust-analyzer is not installed
      if vim.fn.executable "rust-analyzer" == 0 then
        vim.notify(
          "rust-analyzer not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
          vim.log.levels.ERROR,
          { title = "rustaceanvim" }
        )
      end
    end,
  },

  -- Mason tool installation
  {
    "mason.nvim",
    opts = {
      ensure_installed = {
        "codelldb", -- Debugger for Rust
        -- Conditionally install bacon tools
        vim.g.lazyvim_rust_diagnostics == "bacon-ls" and "bacon" or nil,
        vim.g.lazyvim_rust_diagnostics == "bacon-ls" and "bacon-ls" or nil,
      },
    },
  },

  -- Testing support with neotest
  {
    "nvim-neotest/neotest",
    optional = false,
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {}, -- Rust test adapter
      },
    },
  },
}
