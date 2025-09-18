-- Load NvChad defaults
require "nvchad.mappings"

local map = vim.keymap.set

-- Quick command mode
map("n", ";", ":", { desc = "Enter command mode" })

-- Quick escape from insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Select all text
map("n", "<leader>a", "ggv$G$", { desc = "Select all text" })

-- Project management
map("n", "<leader>tT", "<cmd>Telescope<cr>", { desc = "Telescope (builtin)" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Select Branch" })

-- Color picker and management
map("n", "<leader>cp", "<cmd>Huefy<CR>", { desc = "Open color picker (Minty)" })
map("n", "<leader>cs", "<cmd>Shades<CR>", { desc = "Open color shades (Minty)" })

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
