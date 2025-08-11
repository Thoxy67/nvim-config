require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", "<leader>a", "ggv$G$", { desc = "Select all text" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Ccc
map("n", "cc", "<cmd>CccConvert<CR>", { desc = "Ccc Change Color space" })
map("n", "ch", "<cmd>CccHighlighterToggle<CR>", { desc = "Ccc Toggle Color highlighter" })
map("n", "cp", "<cmd>CccPick<CR>", { desc = "Ccc Open Color Picker" })

-- Spectre
map("n", "<leader>fR", "<cmd>Spectre<cr>", { desc = "Spectre Find And Replace", silent = true })

-- Proot
map("n", "<leader>fp", "<cmd>Proot<cr>", { desc = "Proot Toggle Project explorer", silent = true })

-- Diffview
map("n", "<leader>dv", "<cmd>DiffviewOpen<CR>", { desc = "Diffview open" })
map("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Diffview close" })

-- Markdown-Preview
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown Preview" })

-- Neogit
map("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit Open" })

-- Outline
map("n", "<leader>oo", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

-- Oil
map("n", "<leader>fo", "<cmd>Oil<CR>", { desc = "Oil Files Manage" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
