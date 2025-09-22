return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for better prompt input, and required to use `opencode.nvim`'s embedded terminal — otherwise optional
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    config = function()
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`
      }
      -- Required for `opts.auto_reload`
      vim.opt.autoread = true
    end,
    -- stylua: ignore
    keys = {
      { "<leader>0", nil, desc = "AI/OpenCode" },
      { "<leader>0t", function() require("opencode").toggle() end, desc = "Toggle opencode" },
      { "<leader>0A", function() require("opencode").ask() end, desc = "Ask opencode" },
      { "<leader>0a", function() require("opencode").ask "@cursor: " end, desc = "Ask opencode about this" },
      { "<leader>0a", function() require("opencode").ask "@selection: " end, mode = "v", desc = "Ask opencode about selection" },
      { "<leader>0n", function() require("opencode").command "session_new" end, desc = "New opencode session" },
      { "<leader>0y", function() require("opencode").command "messages_copy" end, desc = "Copy last opencode response" },
      { "<S-C-u>", function() require("opencode").command "messages_half_page_up" end, desc = "Messages half page up" },
      { "<S-C-d>", function() require("opencode").command "messages_half_page_down" end, desc = "Messages half page down" },
      { "<leader>0s", function() require("opencode").select() end, mode = { "n", "v" }, desc = "Select opencode prompt" },
      { "<leader>0e", function() require("opencode").prompt "Explain @cursor and its context" end, desc = "Explain this code" },
    },
  },
}
