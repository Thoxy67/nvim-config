-- ============================================================================
-- TYPESCRIPT/JAVASCRIPT LANGUAGE SUPPORT
-- lua/plugins/languages/typescript.lua
-- ============================================================================
-- Comprehensive TypeScript/JavaScript development environment with:
-- - Dual LSP servers (ts_ls and vtsls) for enhanced functionality
-- - Advanced inlay hints and completion features
-- - Debug adapter protocol (DAP) support
-- - File type icons and Mason tool integration
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- TypeScript LSP selection: 'ts_ls' or 'vtsls'
-- vtsls provides more advanced features like better inlay hints and completion
vim.g.typescript_lsp = vim.g.typescript_lsp or "vtsls"

-- ==================== TYPESCRIPT LANGUAGE SERVER (ts_ls) ====================
-- Basic TypeScript language server configuration
-- Provides core TypeScript/JavaScript language features
vim.lsp.config.ts_ls = {
  on_attach = on_attach,
  enabled = vim.g.typescript_lsp == "ts_ls", -- Enable only if selected
  filetypes = {
    "javascript", -- Standard JavaScript files
    "javascriptreact", -- React JSX files
    "javascript.jsx", -- JSX files
    "typescript", -- TypeScript files
    "typescriptreact", -- React TSX files
    "typescript.tsx", -- TSX files
  },
  root_markers = { "tsconfig.json", "package.json", "jsconfig.json" },
  settings = {
    ts_ls = {
      -- Basic settings (extended configuration in vtsls)
    },
  },
}

-- ==================== VTSLS (ENHANCED TYPESCRIPT SERVER) ====================
-- Advanced TypeScript language server with extended features
-- Provides enhanced IntelliSense, refactoring, and completion capabilities
vim.lsp.config.vtsls = {
  on_attach = on_attach,
  enabled = vim.g.typescript_lsp == "vtsls", -- Enable only if selected
  filetypes = {
    "javascript", -- Standard JavaScript files
    "javascriptreact", -- React JSX files
    "javascript.jsx", -- JSX files
    "typescript", -- TypeScript files
    "typescriptreact", -- React TSX files
    "typescript.tsx", -- TSX files
  },
  root_markers = { "tsconfig.json", "package.json", "jsconfig.json" },
  settings = {
    complete_function_calls = true, -- Auto-complete function parameters

    vtsls = {
      enableMoveToFileCodeAction = true, -- Enable file refactoring actions
      autoUseWorkspaceTsdk = true, -- Auto-detect workspace TypeScript version
      experimental = {
        maxInlayHintLength = 30, -- Limit hint length for readability
        completion = {
          enableServerSideFuzzyMatch = true, -- Improved completion matching
        },
      },
    },

    typescript = {
      -- ==================== IMPORT MANAGEMENT ====================
      updateImportsOnFileMove = { enabled = "always" }, -- Auto-update imports on file moves

      -- ==================== COMPLETION SETTINGS ====================
      suggest = {
        completeFunctionCalls = true, -- Show complete function signatures
      },

      -- ==================== INLAY HINTS CONFIGURATION ====================
      inlayHints = {
        enumMemberValues = { enabled = true }, -- Show enum values
        functionLikeReturnTypes = { enabled = true }, -- Show return types
        parameterNames = { enabled = "literals" }, -- Show parameter names for literals
        parameterTypes = { enabled = true }, -- Show parameter types
        propertyDeclarationTypes = { enabled = true }, -- Show property types
        variableTypes = { enabled = false }, -- Hide variable types (can be verbose)
      },
    },

    keys = {}, -- Custom keybindings (empty for default behavior)
  },
}

vim.lsp.enable { vim.g.typescript_lsp }

return {
  { import = "plugins.languages.web" },

  {
    "nvim-mini/mini.icons",
    opts = {
      file = {
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
        ["bun.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "js-debug-adapter")
        end,
      },
    },
    opts = function()
      local dap = require("dap")

      for _, adapterType in ipairs({ "node", "chrome", "msedge" }) do
        local pwaType = "pwa-" .. adapterType

        if not dap.adapters[pwaType] then
          dap.adapters[pwaType] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
              command = "js-debug-adapter",
              args = { "${port}" },
            },
          }
        end

        -- Define adapters without the "pwa-" prefix for VSCode compatibility
        if not dap.adapters[adapterType] then
          dap.adapters[adapterType] = function(cb, config)
            local nativeAdapter = dap.adapters[pwaType]

            config.type = pwaType

            if type(nativeAdapter) == "function" then
              nativeAdapter(cb, config)
            else
              cb(nativeAdapter)
            end
          end
        end
      end

      local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

      local vscode = require("dap.ext.vscode")
      vscode.type_to_filetypes["node"] = js_filetypes
      vscode.type_to_filetypes["pwa-node"] = js_filetypes

      for _, language in ipairs(js_filetypes) do
        if not dap.configurations[language] then
          local runtimeExecutable = nil
          if language:find("typescript") then
            runtimeExecutable = vim.fn.executable("tsx") == 1 and "tsx" or "ts-node"
          end
          dap.configurations[language] = {
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
              sourceMaps = true,
              runtimeExecutable = runtimeExecutable,
              skipFiles = {
                "<node_internals>/**",
                "node_modules/**",
              },
              resolveSourceMapLocations = {
                "${workspaceFolder}/**",
                "!**/node_modules/**",
              },
            },
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
              sourceMaps = true,
              runtimeExecutable = runtimeExecutable,
              skipFiles = {
                "<node_internals>/**",
                "node_modules/**",
              },
              resolveSourceMapLocations = {
                "${workspaceFolder}/**",
                "!**/node_modules/**",
              },
            },
          }
        end
      end
    end,
  },
}
