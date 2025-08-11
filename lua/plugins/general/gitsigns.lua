-- gitsigns.lua - Git integration with signs, hunks, and blame
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- Visual indicators for git changes in the sign column
      signs = {
        add = { text = "▎" }, -- Added lines
        change = { text = "▎" }, -- Modified lines
        delete = { text = "" }, -- Deleted lines
        topdelete = { text = "" }, -- Deleted lines at top
        changedelete = { text = "▎" }, -- Modified and deleted
        untracked = { text = "▎" }, -- Untracked files
      },
      -- Signs for staged changes
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },

      -- Setup keymaps when gitsigns attaches to a buffer
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = "Gitsigns " .. desc })
        end

        -- ==================== HUNK NAVIGATION ====================
        -- Next/previous hunk navigation
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            gs.nav_hunk "next"
          end
        end, "Navigate to next hunk")

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            gs.nav_hunk "prev"
          end
        end, "Navigate to previous hunk")

        -- Jump to first/last hunk in buffer
        map("n", "]H", function()
          gs.nav_hunk "last"
        end, "Navigate to last hunk in buffer")
        map("n", "[H", function()
          gs.nav_hunk "first"
        end, "Navigate to first hunk in buffer")

        -- ==================== HUNK ACTIONS ====================
        -- Stage and reset individual hunks
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage current hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset current hunk to HEAD")

        -- Buffer-wide operations
        map("n", "<leader>ghS", gs.stage_buffer, "Stage all hunks in current buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo last hunk staging operation")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset entire buffer to HEAD")

        -- Preview hunk changes
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview hunk changes inline")

        -- ==================== BLAME FUNCTIONALITY ====================
        -- Show blame information for current line
        map("n", "<leader>ghb", function()
          gs.blame_line { full = true }
        end, "Show blame info for current line")

        -- Show blame for entire buffer
        map("n", "<leader>ghB", function()
          gs.blame()
        end, "Show blame for entire buffer")

        -- ==================== DIFF FUNCTIONALITY ====================
        -- Diff current buffer against index
        map("n", "<leader>ghd", gs.diffthis, "Diff current buffer against index")

        -- Diff current buffer against last commit
        map("n", "<leader>ghD", function()
          gs.diffthis "~"
        end, "Diff current buffer against last commit")

        -- ==================== TEXT OBJECTS ====================
        -- Git hunk as text object for operations
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select current hunk as text object")
      end,
    },
  },
}
