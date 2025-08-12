-- ============================================================================
-- AUTOCOMMANDS AND USER COMMANDS CONFIGURATION
-- lua/autocmds.lua
-- ============================================================================
-- This file contains custom autocommands and user commands that extend
-- NvChad's functionality with additional automation and convenience commands.
-- ============================================================================

-- Load NvChad's default autocommands first
require "nvchad.autocmds"

-- ============================================================================
-- UTILITY FUNCTIONS FOR COMMANDS
-- ============================================================================

-- Auto Commands helper
local autocmd = vim.api.nvim_create_autocmd

-- User Command helper
local usercmd = vim.api.nvim_create_user_command

-- ============================================================================
-- CONFIGURATION MANAGEMENT COMMANDS
-- ============================================================================

-- Command to quickly open and navigate to NvChad configuration
usercmd("NvConfig", function()
  local config_path = vim.fn.stdpath "config"

  -- Change to config directory and open init file
  vim.cmd("cd " .. config_path)
  vim.cmd "e $MYVIMRC"

  -- Notify user of directory change
  vim.notify("📁 Open Config directory: " .. config_path, vim.log.levels.INFO, {
    title = "Directory Changed",
  })
end, {
  desc = "Open NvChad config directory and main configuration file",
})

-- ============================================================================
-- UPDATE MANAGEMENT COMMANDS
-- ============================================================================

-- Comprehensive update command for all components
usercmd("NvUpdate", function()
  vim.notify("🔄 Starting update process...", vim.log.levels.INFO, {
    title = "NvUpdate",
  })

  -- ==================== UPDATE SEQUENCE ====================
  -- Run updates in logical order for dependencies

  -- 1. Update TreeSitter parsers (syntax highlighting)
  vim.cmd "TSUpdate"

  -- 2. Update Mason registry
  vim.cmd "MasonUpdate"

  -- 3. Update Mason packages (LSP servers, formatters, etc.)
  vim.cmd "MasonUpdate"

  -- 4. Sync Lazy plugins (install missing, update existing)
  require("lazy").sync { wait = true, show = true }

  -- 5. Update all Lazy plugins to latest versions
  require("lazy").update { wait = true, show = false }

  -- Completion notification
  vim.notify("✅ Update process completed!", vim.log.levels.INFO, {
    title = "NvUpdate",
  })
end, {
  desc = "Update TreeSitter parsers, Mason tools, and Lazy plugins comprehensively",
})

-- ============================================================================
-- FILE SYSTEM INTEGRATION
-- ============================================================================

-- Cross-platform file explorer command
usercmd("Explore", function(opts)
  local path = opts.args ~= "" and opts.args or "."
  local cmd

  -- ==================== PLATFORM DETECTION ====================
  -- Use appropriate file manager for the operating system
  if vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1 then
    cmd = "explorer " .. path -- Windows Explorer
  else
    cmd = "open " .. path -- macOS Finder / Linux default
  end

  -- Execute the system command
  vim.fn.system(cmd)
end, {
  nargs = "?", -- Optional argument
  complete = "dir", -- Directory completion
  desc = "Open system file browser at specified directory or current directory",
})

-- ============================================================================
-- DEBUG INTEGRATION COMMANDS
-- ============================================================================

-- Quick DAP UI toggle command
usercmd("DapUIToggle", function()
  require("dapui").toggle()
end, {
  desc = "Toggle Debug Adapter Protocol UI",
})

-- ============================================================================
-- FORMATTING COMMANDS
-- ============================================================================

-- Manual formatting command using conform.nvim
usercmd("FormatFile", function()
  require("conform").format {
    lsp_fallback = true, -- Use LSP formatting if no formatter configured
  }
end, {
  desc = "Format current file using conform.nvim with LSP fallback",
})

usercmd("RunHarpoon", function()
  -- Telescope integration for harpoon list
  local conf = require("telescope.config").values
  local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(file_paths, item.value)
    end

    require("telescope.pickers")
      .new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table {
          results = file_paths,
        },
        previewer = conf.file_previewer {},
        sorter = conf.generic_sorter {},
      })
      :find()
  end

  toggle_telescope(require("harpoon"):list())
end, { desc = "" })
