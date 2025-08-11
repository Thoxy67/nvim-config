-- Load NvChad defaults
require "nvchad.mappings"

local map = vim.keymap.set

-- ===========================
-- GENERAL MAPPINGS
-- ===========================

-- Quick command mode
map("n", ";", ":", { desc = "Enter command mode" })

-- Quick escape from insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Select all text
map("n", "<leader>a", "ggv$G$", { desc = "Select all text" })

-- ===========================
-- FILE OPERATIONS
-- ===========================

-- File management
map("n", "<leader>fo", "<cmd>Oil<CR>", { desc = "Open Oil file manager" })
map("n", "<leader>-", "<cmd>Yazi<cr>", { desc = "Open Yazi file manager" })

-- Project management
map("n", "<leader>fp", "<cmd>Proot<cr>", { desc = "Open project explorer" })

-- ===========================
-- GIT OPERATIONS
-- ===========================

-- Git interfaces
map("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Open Neogit" })

-- Diff view
map("n", "<leader>dv", "<cmd>DiffviewOpen<CR>", { desc = "Open diff view" })
map("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" })

-- ===========================
-- SEARCH AND REPLACE
-- ===========================

-- Global find and replace
map("n", "<leader>fR", "<cmd>Spectre<cr>", { desc = "Open Spectre find/replace" })
map("n", "<leader>gr", function()
  -- Toggle GrugFar (if available)
  local ok, _ = pcall(require, "grug-far")
  if ok then
    vim.cmd "GrugFar"
  else
    vim.notify("GrugFar not available", vim.log.levels.WARN)
  end
end, { desc = "Toggle GrugFar find/replace" })

-- ===========================
-- CODE UTILITIES
-- ===========================

-- Color picker and management
map("n", "<leader>cF", "<cmd>CccConvert<CR>", { desc = "Convert color format" })
map("n", "<leader>cH", "<cmd>CccHighlighterToggle<CR>", { desc = "Toggle color highlighter" })
map("n", "<leader>cP", "<cmd>CccPick<CR>", { desc = "Open color picker (CCC)" })
map("n", "<leader>cp", "<cmd>Huefy<CR>", { desc = "Open color picker (Minty)" })
map("n", "<leader>cs", "<cmd>Shades<CR>", { desc = "Open color shades (Minty)" })

-- Code outline
map("n", "<leader>oo", "<cmd>Outline<CR>", { desc = "Toggle code outline" })

-- ===========================
-- MARKDOWN
-- ===========================

-- Markdown preview
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle markdown preview" })

-- ===========================
-- MOVEMENT AND NAVIGATION
-- ===========================

-- Quick jump to context (indent-blankline)
map("n", "<leader>cc", function()
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
