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

autocmd("FileType", {
  callback = function()
    -- TODO: nvim 0.12 will make error = false the default so we can remove it
    if vim.treesitter.get_parser(nil, nil, { error = false }) then
      vim.treesitter.start()
    end
  end,
})

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
  vim.cmd "MasonUpdateAll"

  -- 4. Sync Lazy plugins (install missing, update existing)
  require("lazy").sync { wait = true, show = true }

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
    cmd = "xdg-open " .. path -- macOS Finder / Linux default
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

-- ============================================================================
-- LANGUAGE PLUGIN MANAGEMENT COMMANDS
-- ============================================================================

-- Language plugin manager UI
usercmd("LanguageManager", function()
  require("configs.language_ui").show_language_manager()
end, {
  desc = "Open language plugin manager UI to enable/disable language support",
})

-- Quick language toggle with completion
usercmd("LanguageToggle", function(opts)
  if opts.args and opts.args ~= "" then
    local lang_manager = require("configs.language_manager")
    local found_lang = nil

    for _, lang_info in ipairs(lang_manager.available_languages) do
      if string.lower(lang_info.name) == string.lower(opts.args) or
         string.lower(lang_info.display) == string.lower(opts.args) then
        found_lang = lang_info
        break
      end
    end

    if found_lang then
      local new_state = lang_manager.toggle_language(found_lang.name)
      local action = new_state and "enabled" or "disabled"
      vim.notify(
        string.format("Language '%s' %s", found_lang.display, action),
        vim.log.levels.INFO,
        { title = "Language Manager" }
      )
    else
      vim.notify("Language not found: " .. opts.args, vim.log.levels.WARN)
    end
  else
    require("configs.language_ui").quick_toggle()
  end
end, {
  nargs = "?",
  complete = function(_, _, _)
    local lang_manager = require("configs.language_manager")
    local completions = {}
    for _, lang_info in ipairs(lang_manager.available_languages) do
      table.insert(completions, lang_info.name)
      table.insert(completions, lang_info.display)
    end
    return completions
  end,
  desc = "Toggle language plugin (with optional language argument)",
})
