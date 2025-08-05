return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = "Gitsigns " .. desc })
        end

        -- Hunk navigation
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Navigate to next hunk")

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Navigate to previous hunk")

        map("n", "]H", function() gs.nav_hunk("last") end, "Navigate to last hunk in buffer")
        map("n", "[H", function() gs.nav_hunk("first") end, "Navigate to first hunk in buffer")

        -- Hunk actions
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage current hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset current hunk to HEAD")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage all hunks in current buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo last hunk staging operation")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset entire buffer to HEAD")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview hunk changes inline")

        -- Blame functionality
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Show blame info for current line")
        map("n", "<leader>ghB", function() gs.blame() end, "Show blame for entire buffer")

        -- Diff functionality
        map("n", "<leader>ghd", gs.diffthis, "Diff current buffer against index")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff current buffer against last commit")

        -- Text objects
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select current hunk as text object")
      end,
    },
  }
}
