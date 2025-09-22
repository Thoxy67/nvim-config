return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    -- stylua: ignore
    keys = {
      { "<leader>1", nil, desc = "AI/Claude Code" },
      { "<leader>1c", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>1f", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>1r", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>1C", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>1m", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>1b", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>1s", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      { "<leader>1s", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file", ft = { "NvimTree", "neo-tree", "oil", "minifiles" }},
      -- Diff management
      { "<leader>1a", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>1d", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
