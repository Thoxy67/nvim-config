-- ============================================================================
-- GODOT GDSCRIPT LANGUAGE SUPPORT
-- lua/plugins/languages/godot.lua
-- ============================================================================
-- Comprehensive Godot GDScript development environment featuring:
-- - LSP support via Godot's built-in language server
-- - Neovim server mode for external editor integration
-- - Treesitter support for syntax highlighting
-- - Custom debugging commands (breakpoint management)
-- - Godot-specific utilities and keybindings
-- ============================================================================

local on_attach = require("nvchad.configs.lspconfig").on_attach

-- ==================== GODOT PROJECT DETECTION ====================
-- Paths to check for project.godot file
local paths_to_check = { "/", "/../" }
local is_godot_project = false
local godot_project_path = ""
local cwd = vim.fn.getcwd()

-- Iterate over paths and check for Godot project
for _, value in ipairs(paths_to_check) do
  if vim.uv.fs_stat(cwd .. value .. "project.godot") then
    is_godot_project = true
    godot_project_path = cwd .. value
    break
  end
end

-- ==================== NEOVIM SERVER MODE ====================
-- Start Neovim server for Godot external editor integration
-- This creates a named pipe that Godot can use to send commands to Neovim
--
-- GODOT EDITOR SETUP:
-- To use Neovim as external editor in Godot, configure these settings:
-- Editor Settings > Text Editor > External:
--   1. Enable "Use External Editor"
--   2. Set "Exec Path" to your nvim binary path
--   3. Set "Exec Flags" to:
--      --server {project}/server.pipe --remote-send "<C-\><C-N>:e {file}<CR>:call cursor({line}+1,{col})<CR>"
--
-- Command breakdown:
--   --server {project}/server.pipe    : Connect to the Neovim server instance
--   --remote-send                     : Send commands to the server
--   <C-\><C-N>                        : Exit to Normal mode from any mode
--   :e {file}                         : Edit/open the file clicked in Godot
--   <CR>                              : Execute the edit command
--   :call cursor({line}+1,{col})      : Move cursor to line and column (+1 for correct line)
--   <CR>                              : Execute the cursor movement
--
-- Additionally, enable "Debug with External Editor" in Godot's Script view settings
-- to use Neovim during debugging sessions.
if is_godot_project then
  local is_server_running = vim.uv.fs_stat(godot_project_path .. "/server.pipe")
  if not is_server_running then
    vim.fn.serverstart(godot_project_path .. "/server.pipe")
  end
end

-- ==================== LSP CONFIGURATION ====================
-- Configure Godot LSP (runs within Godot Editor)
--
-- IMPORTANT: The LSP runs inside the Godot Editor, so you need to have your
-- Godot project open in the editor for LSP features to work.
--
-- RECOMMENDED GODOT SETTINGS:
-- Editor Settings > Network > Language Server > "Use Thread" = true
--   This runs the LSP in a separate thread, which significantly improves
--   stability and reduces the need to restart the LSP. Without this setting,
--   you may experience issues with auto-complete not working or needing to
--   frequently run :LspRestart.
--
-- LSP FEATURES:
--   - Code completion (Ctrl+x Ctrl+o in insert mode)
--   - Go to definition (Ctrl+] on function/class names)
--   - Hover documentation (K on symbols)
--   - Diagnostics and error checking
--   - The LSP connects via TCP on port 6005 by default
if is_godot_project then
  vim.lsp.config.gdscript = {
    on_attach = on_attach,
    filetypes = { "gd", "gdscript", "gdscript3" },
    root_markers = { "project.godot", ".git" },
    settings = {},
  }

  vim.lsp.enable { "gdscript" }
end

-- ==================== CUSTOM COMMANDS ====================
-- Godot-specific commands and keybindings
if is_godot_project then
  -- Write breakpoint to new line
  vim.api.nvim_create_user_command("GodotBreakpoint", function()
    vim.cmd "normal! obreakpoint"
    vim.cmd "write"
  end, {})
  vim.keymap.set("n", "<leader>db", ":GodotBreakpoint<CR>", { desc = "Add Godot Breakpoint" })

  -- Delete all breakpoints in current file
  vim.api.nvim_create_user_command("GodotDeleteBreakpoints", function()
    vim.cmd "g/^\\s*breakpoint\\s*$/d"
  end, {})
  vim.keymap.set("n", "<leader>dB", ":GodotDeleteBreakpoints<CR>", { desc = "Delete All Godot Breakpoints" })

  -- Search all breakpoints in project
  vim.api.nvim_create_user_command("GodotFindBreakpoints", function()
    vim.cmd ":grep breakpoint | copen"
  end, {})
  vim.keymap.set("n", "<leader>dF", ":GodotFindBreakpoints<CR>", { desc = "Find Godot Breakpoints" })

  -- Append "# TRANSLATORS: " to current line
  vim.api.nvim_create_user_command("GodotTranslators", function()
    vim.cmd "normal! A # TRANSLATORS: "
  end, {})
  vim.keymap.set("n", "<leader>gt", ":GodotTranslators<CR>", { desc = "Add Godot Translator Comment" })

  -- Run current scene (requires godot in PATH)
  vim.api.nvim_create_user_command("GodotRunScene", function()
    local current_file = vim.fn.expand "%:p"
    vim.cmd("!godot --path " .. godot_project_path .. " " .. current_file .. " &")
  end, {})
  vim.keymap.set("n", "<leader>gr", ":GodotRunScene<CR>", { desc = "Run Current Godot Scene" })

  -- Run project (requires godot in PATH)
  vim.api.nvim_create_user_command("GodotRunProject", function()
    vim.cmd("!godot --path " .. godot_project_path .. " &")
  end, {})
  vim.keymap.set("n", "<leader>gR", ":GodotRunProject<CR>", { desc = "Run Godot Project" })
end

-- ==================== PLUGIN CONFIGURATIONS ====================
return {
  -- Treesitter support for GDScript syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "gdscript", -- GDScript language
        "godot_resource", -- Godot resource files (.tres, .tscn)
        "gdshader", -- Godot shader language
      },
    },
  },

  -- File type detection for Godot files
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      -- Add filetype associations
      vim.filetype.add {
        extension = {
          gd = "gdscript",
          tscn = "godot_resource",
          tres = "godot_resource",
          gdshader = "gdshader",
        },
      }
    end,
  },
}
