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
    "epwalsh/obsidian.nvim",
    ft = "markdown", -- Load for markdown files
    cmd = { -- Also load when any Obsidian command is used
      "ObsidianOpen",
      "ObsidianNew",
      "ObsidianQuickSwitch",
      "ObsidianFollowLink",
      "ObsidianBacklinks",
      "ObsidianTags",
      "ObsidianToday",
      "ObsidianYesterday",
      "ObsidianTomorrow",
      "ObsidianDailies",
      "ObsidianTemplate",
      "ObsidianSearch",
      "ObsidianLink",
      "ObsidianLinkNew",
      "ObsidianLinks",
      "ObsidianExtractNote",
      "ObsidianWorkspace",
      "ObsidianPasteImg",
      "ObsidianRename",
      "ObsidianToggleCheckbox",
      "ObsidianNewFromTemplate",
      "ObsidianTOC",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/Obsidian Vault/",
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
