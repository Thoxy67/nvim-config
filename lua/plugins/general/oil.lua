-- oil.lua - File explorer as a buffer
return {
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function(_, opts)
      require("oil").setup(opts)
    end,
  },
  {
    -- Git status integration for oil
    "SirZenith/oil-vcs-status",
    event = "VeryLazy",
    dependencies = { "stevearc/oil.nvim" },
    config = true,
    opts = function(_, opts)
      local status_const = require "oil-vcs-status.constant.status"
      local StatusType = status_const.StatusType

      local new_opts = {
        -- Git status symbols
        status_symbol = {
          [StatusType.Added] = "",
          [StatusType.Copied] = "",
          [StatusType.Deleted] = "",
          [StatusType.Ignored] = "",
          [StatusType.Modified] = "",
          [StatusType.Renamed] = "",
          [StatusType.TypeChanged] = "",
          [StatusType.Unmodified] = " ",
          [StatusType.Unmerged] = "",
          [StatusType.Untracked] = "",
          [StatusType.External] = "",
          -- Upstream status symbols
          [StatusType.UpstreamAdded] = "",
          [StatusType.UpstreamCopied] = "",
          [StatusType.UpstreamDeleted] = "",
          [StatusType.UpstreamIgnored] = " ",
          [StatusType.UpstreamModified] = "",
          [StatusType.UpstreamRenamed] = "",
          [StatusType.UpstreamTypeChanged] = "",
          [StatusType.UpstreamUnmodified] = " ",
          [StatusType.UpstreamUnmerged] = "",
          [StatusType.UpstreamUntracked] = " ",
          [StatusType.UpstreamExternal] = "",
        },
        -- Highlight groups for different status types
        status_hl_group = {
          [StatusType.Added] = "DiffviewStatusAdded",
          [StatusType.Copied] = "DiffviewNormal",
          [StatusType.Deleted] = "DiffviewStatusDeleted",
          [StatusType.Ignored] = "DiffviewNonText",
          [StatusType.Modified] = "Normal",
          [StatusType.Renamed] = "DiffviewFolderSign",
          [StatusType.TypeChanged] = "DiffModified",
          [StatusType.Unmodified] = "Normal",
          [StatusType.Unmerged] = "diffOldFile",
          [StatusType.Untracked] = "DiffviewFolderSign",
          [StatusType.External] = "diffOldFile",
          -- Upstream highlight groups
          [StatusType.UpstreamAdded] = "DiffAdd",
          [StatusType.UpstreamCopied] = "DiffAdd",
          [StatusType.UpstreamDeleted] = "DiffAdd",
          [StatusType.UpstreamIgnored] = "DiffAdd",
          [StatusType.UpstreamModified] = "DiffAdd",
          [StatusType.UpstreamRenamed] = "DiffAdd",
          [StatusType.UpstreamTypeChanged] = "DiffAdd",
          [StatusType.UpstreamUnmodified] = "DiffAdd",
          [StatusType.UpstreamUnmerged] = "DiffAdd",
          [StatusType.UpstreamUntracked] = "DiffAdd",
          [StatusType.UpstreamExternal] = "DiffAdd",
        },
      }

      opts = vim.tbl_deep_extend("force", opts, new_opts)
      return opts
    end,
  },
}
