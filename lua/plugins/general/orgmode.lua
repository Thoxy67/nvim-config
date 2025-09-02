return {
  {
    "nvim-orgmode/orgmode",
    ft = { "org" },
    cmd = { "Org" },
    dependencies = {
      "akinsho/org-bullets.nvim",
    },
    config = function()
      -- Setup orgmode
      require("orgmode").setup {
        org_agenda_files = "~/Dev/orgfiles/**/*",
        org_default_notes_file = "~/Dev/orgfiles/default.org",
      }
    end,
  },
}
