vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(opts)
    if vim.bo[opts.buf].filetype == "markdown" then
      vim.wo.conceallevel = 2
      vim.wo.cole = 2
    end
  end,
})

return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown", -- Load for markdown files
    cmd = { "Obsidian" }, -- Main entry point command in new version
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/Obsidian Vault/",
        },
      },
      
      -- Disable legacy commands to remove warning
      legacy_commands = false,
      
      -- Optional: configure completion
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      
      -- Optional: UI configuration
      ui = {
        enable = true,
      },
      
      -- Checkbox configuration (new format)
      checkbox = {
        order = { " ", "x", ">", "~", "!" },
        chars = {
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
        },
      },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)
      vim.wo.conceallevel = 1
      vim.wo.cole = 1
    end,
  },
}
