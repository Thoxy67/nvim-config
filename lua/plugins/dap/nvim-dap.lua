-- ============================================================================
-- DEBUG ADAPTER PROTOCOL (DAP) CONFIGURATION
-- lua/plugins/dap/nvim-dap.lua
-- ============================================================================
-- This file configures the Debug Adapter Protocol for Neovim, providing
-- comprehensive debugging support across multiple programming languages.
-- DAP allows step-through debugging, breakpoints, variable inspection, and more.
-- ============================================================================

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

-- Function to handle command line arguments for debugging sessions
---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
  local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
    -- Special handling for Java debugging
    if config.type and config.type == "java" then
      ---@diagnostic disable-next-line: return-type-mismatch
      return new_args
    end
    return require("dap.utils").splitstr(new_args)
  end
  return config
end

-- ============================================================================
-- MAIN DAP CONFIGURATION
-- ============================================================================

return {
  {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debug Adapter Protocol - Provides debugging support for multiple languages",

    dependencies = {
      -- ============================================================================
      -- DAP UI - VISUAL DEBUGGING INTERFACE
      -- ============================================================================
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" }, -- Required for async operations

        -- DAP UI specific keymaps
        keys = {
          {
            "<leader>du",
            function()
              require("dapui").toggle {}
            end,
            desc = "Dap UI Toggle",
          },
          {
            "<leader>de",
            function()
              require("dapui").eval()
            end,
            desc = "Dap Eval Expression",
            mode = { "n", "v" },
          },
        },

        opts = {
          -- DAP UI configuration can be customized here
          -- The UI will automatically open/close with debug sessions
        },

        config = function(_, opts)
          -- Load DAP theme integration
          dofile(vim.g.base46_cache .. "dap")

          local dap = require "dap"
          local dapui = require "dapui"
          dapui.setup(opts)

          -- ==================== DAP UI AUTO MANAGEMENT ====================
          -- Automatically open DAP UI when debugging starts
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open {}
          end

          -- Automatically close DAP UI when debugging ends
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close {}
          end

          -- Automatically close DAP UI when debugging exits
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close {}
          end
        end,
      },

      -- ============================================================================
      -- MASON DAP INTEGRATION
      -- ============================================================================
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },

        opts = {
          -- chrome adapter is deprecated, use js-debug-adapter instead
          automatic_installation = { exclude = { "chrome" } },

          -- Custom handler configuration for different debug adapters
          -- You can provide additional configuration to the handlers
          handlers = {
            -- Example custom handler:
            -- python = function(config)
            --   config.adapters.python = {
            --     type = "executable",
            --     command = "/usr/bin/python3",
            --     args = { "-m", "debugpy.adapter" },
            --   }
            --   require('mason-nvim-dap').default_setup(config)
            -- end,
          },

          -- Debug adapters to ensure are installed
          -- Add language-specific debuggers here
          ensure_installed = {
            -- Add debuggers for your languages:
            -- "python",     -- Python debugger
            -- "codelldb",   -- Rust/C/C++ debugger (installed via language configs)
            -- "delve",      -- Go debugger (installed via language configs)
            -- "js-debug",   -- JavaScript/TypeScript debugger
          },
        },

        -- Mason-nvim-dap is loaded when nvim-dap loads
        config = function() end,
      },

      -- ============================================================================
      -- VIRTUAL TEXT INTEGRATION
      -- ============================================================================
      {
        "theHamsta/nvim-dap-virtual-text",
        event = "LspAttach",
        desc = "Display variable values as virtual text during debugging",
        config = function(_, opts)
          require("nvim-dap-virtual-text").setup(opts)
        end,
      },
    },

    -- ============================================================================
    -- DAP KEYMAPS
    -- ============================================================================
    -- Comprehensive debugging keymaps for all common operations
    keys = {
      -- ==================== BREAKPOINT MANAGEMENT ====================
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
        end,
        desc = "Dap Breakpoint Condition",
      },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Dap Toggle Breakpoint",
      },

      -- ==================== SESSION CONTROL ====================
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Dap Run/Continue",
      },
      {
        "<leader>da",
        function()
          require("dap").continue { before = get_args }
        end,
        desc = "Dap Run with Args",
      },
      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Dap Run to Cursor",
      },
      {
        "<leader>dg",
        function()
          require("dap").goto_()
        end,
        desc = "Dap Go to Line (No Execute)",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Dap Run Last",
      },
      {
        "<leader>dP",
        function()
          require("dap").pause()
        end,
        desc = "Dap Pause",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Dap Terminate",
      },

      -- ==================== STEP CONTROL ====================
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Dap Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Dap Step Out",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_over()
        end,
        desc = "Dap Step Over",
      },

      -- ==================== STACK NAVIGATION ====================
      {
        "<leader>dj",
        function()
          require("dap").down()
        end,
        desc = "Dap Down",
      },
      {
        "<leader>dk",
        function()
          require("dap").up()
        end,
        desc = "Dap Up",
      },

      -- ==================== REPL AND INSPECTION ====================
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Dap Toggle REPL",
      },
      {
        "<leader>ds",
        function()
          require("dap").session()
        end,
        desc = "Dap Session",
      },
      {
        "<leader>dw",
        function()
          require("dap.ui.widgets").hover()
        end,
        desc = "Dap Widgets",
      },
    },

    -- ============================================================================
    -- DAP CONFIGURATION SETUP
    -- ============================================================================
    config = function()
      -- Set highlight for stopped line during debugging
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      -- ==================== VSCODE INTEGRATION ====================
      -- Setup DAP configuration from VSCode launch.json files
      local vscode = require "dap.ext.vscode"
      local json = require "plenary.json"

      -- Custom JSON decoder that strips comments (VSCode allows comments in JSON)
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end
    end,
  },
}
