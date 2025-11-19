-- Load NvChad defaults
require "nvchad.mappings"

local map = vim.keymap.set
local unmap = vim.keymap.del

-- ==================== OVERRIDE NVCHAD TELESCOPE DEFAULTS ====================
-- NvChad loads Telescope mappings by default, we replace them with Snacks
-- See: lazy/NvChad/lua/nvchad/mappings.lua lines 54-75

-- Unmap NvChad's Telescope keybindings
local telescope_maps = {
  { "n", "<leader>fw" }, -- live grep
  { "n", "<leader>fb" }, -- buffers
  { "n", "<leader>fh" }, -- help tags
  { "n", "<leader>ma" }, -- marks
  { "n", "<leader>fo" }, -- oldfiles
  { "n", "<leader>fz" }, -- current buffer fuzzy find
  { "n", "<leader>cm" }, -- git commits
  { "n", "<leader>gt" }, -- git status
  { "n", "<leader>pt" }, -- pick hidden term
  { "n", "<leader>ff" }, -- find files
  { "n", "<leader>fa" }, -- find all files
}

for _, mapping in ipairs(telescope_maps) do
  pcall(unmap, mapping[1], mapping[2])
end

-- Also override conflicting NvChad defaults that conflict with Snacks
pcall(unmap, "n", "<leader>e") -- NvimTree focus -> Snacks explorer
pcall(unmap, "n", "<leader>n") -- toggle line number -> Snacks notifications

-- ==================== REMAP WITH SNACKS EQUIVALENTS ====================
-- Replace unmapped NvChad Telescope commands with Snacks equivalents
-- These provide the same functionality but using Snacks picker

map("n", "<leader>fw", function() require('snacks').picker.grep() end, { desc = "Snacks Live Grep" })
map("n", "<leader>fb", function() require('snacks').picker.buffers() end, { desc = "Snacks Buffers" })
map("n", "<leader>fh", function() require('snacks').picker.help() end, { desc = "Snacks Help Pages" })
map("n", "<leader>ma", function() require('snacks').picker.marks() end, { desc = "Snacks Marks" })
map("n", "<leader>fo", function() require('snacks').picker.recent() end, { desc = "Snacks Recent Files" })
map("n", "<leader>fz", function() require('snacks').picker.lines() end, { desc = "Snacks Buffer Lines" })
map("n", "<leader>cm", function() require('snacks').picker.git_log() end, { desc = "Snacks Git Commits" })
map("n", "<leader>gt", function() require('snacks').picker.git_status() end, { desc = "Snacks Git Status" })
map("n", "<leader>ff", function() require('snacks').picker.files() end, { desc = "Snacks Find Files" })
map("n", "<leader>fa", function() require('snacks').picker.files({ hidden = true, no_ignore = true }) end, { desc = "Snacks Find All Files" })
map("n", "<leader>e", function() require('snacks').explorer() end, { desc = "Snacks File Explorer" })
map("n", "<leader>n", function() require('snacks').picker.notifications() end, { desc = "Snacks Notifications" })

-- Note: <leader>pt (pick hidden term) doesn't have a Snacks equivalent
-- You can still use NvimTree with <C-n> if needed

-- Quick command mode
map("n", ";", ":", { desc = "Enter command mode" })

-- Quick escape from insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Select all text
map("n", "<leader>a", "ggv$G$", { desc = "Select all text" })

-- Project management
-- Note: Telescope is kept installed for plugin dependencies (project.nvim, avante, etc.)
-- but Snacks picker is used for navigation instead
-- Uncomment below if you need Telescope builtin picker
-- map("n", "<leader>tT", "<cmd>Telescope<cr>", { desc = "Telescope (builtin)" })

-- Git branches now handled by Snacks (see snacks.lua line 22: <leader>gb)

-- Color picker and management
map("n", "<leader>cp", "<cmd>Huefy<CR>", { desc = "Open color picker (Minty)" })
map("n", "<leader>cs", "<cmd>Shades<CR>", { desc = "Open color shades (Minty)" })

-- Language plugin manager
map("n", "<leader>lt", "<cmd>LanguageManager<cr>", { desc = "Toggle Language Plugin Manager" })

-- Quick jump to context (indent-blankline)
map("n", "<leader>cj", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local ok, ibl_scope = pcall(require, "ibl.scope")
  if ok then
    local node = ibl_scope.get(vim.api.nvim_get_current_buf(), config)
    if node then
      local start_row, _, end_row, _ = node:range()
      if start_row ~= end_row then
        vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
        vim.api.nvim_feedkeys("_", "n", true)
      end
    end
  end
end, { desc = "Jump to current context" })

-- right click menu using Keyboard
map("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-- right click menu for mouse users + nvimtree users!
map({ "n", "v" }, "<RightMouse>", function()
  require("menu.utils").delete_old_menus()
  vim.cmd.exec '"normal! \\<RightMouse>"'
  -- clicked buf
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})
