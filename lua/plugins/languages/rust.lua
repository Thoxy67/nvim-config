-- ============================================================================
-- RUST LANGUAGE SUPPORT
-- lua/plugins/languages/rust.lua
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

-- Diagnostic provider selection: 'rust-analyzer' or 'bacon-ls'
-- bacon-ls provides faster diagnostics but requires bacon to be installed
vim.g.lazyvim_rust_diagnostics = "bacon-ls"

local diagnostics = vim.g.lazyvim_rust_diagnostics == "rust-analyzer"

-- Configure bacon-ls for fast diagnostics (if selected)
if vim.g.lazyvim_rust_diagnostics == "bacon-ls" then
  lspconfig.bacon_ls.setup {
    on_attach = on_attach,
    settings = {
      -- bacon-ls settings can be configured here
    },
  }
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
          cmp = {
            enabled = false, -- Disable nvim-cmp integration (using blink.cmp)
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
  },

  {
    "Aityz/cratesearch.nvim", -- provide `:CrateSearch [query]` command to search for crates
    config = function()
      require("cratesearch").setup()
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
    version = "^6", -- Use stable version
    lazy = false, -- Load immediately for Rust files
    config = function(_, opts)
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {},

        -- LSP server configuration
        server = {
          on_attach = on_attach,
          root_dir = util.root_pattern("Cargo.toml", "build.rs", ".git"),
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
              checkOnSave = diagnostics == "rust-analyzer",
              diagnostics = {
                enable = diagnostics == "rust-analyzer",
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
          local package_path = vim.fn.expand "$MASON/packages/codelldb/extension/"
          local codelldb = package_path .. "adapter/codelldb"
          local library_path = package_path .. "lldb/lib/liblldb.dylib"

          -- Adjust library path for Linux
          local uname = io.popen("uname"):read "*l"
          if uname == "Linux" then
            library_path = package_path .. "lldb/lib/liblldb.so"
          end

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
