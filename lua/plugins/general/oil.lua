-- oil.lua - File explorer as a buffer
return {
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "SirZenith/oil-vcs-status",
    },
    cmd = { "Oil" },
    keys = {
      {
        "<leader>fo",
        "<cmd>Oil<cr>",
        desc = "Open Oil file manager",
      },
    },
    opts = {
      win_options = {
        signcolumn = "number",
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)
      local status_const = require "oil-vcs-status.constant.status"
      local StatusType = status_const.StatusType

      local new_opts = {
        -- Git status symbols
        status_symbol = {
          [StatusType.Added] = "A",
          [StatusType.Copied] = "C",
          [StatusType.Deleted] = "D",
          [StatusType.Ignored] = "!",
          [StatusType.Modified] = "M",
          [StatusType.Renamed] = "R",
          [StatusType.TypeChanged] = "T",
          [StatusType.Unmodified] = " ",
          [StatusType.Unmerged] = "U",
          [StatusType.Untracked] = "?",
          [StatusType.External] = "X",

          [StatusType.UpstreamAdded] = "A",
          [StatusType.UpstreamCopied] = "C",
          [StatusType.UpstreamDeleted] = "D",
          [StatusType.UpstreamIgnored] = "!",
          [StatusType.UpstreamModified] = "M",
          [StatusType.UpstreamRenamed] = "R",
          [StatusType.UpstreamTypeChanged] = "T",
          [StatusType.UpstreamUnmodified] = " ",
          [StatusType.UpstreamUnmerged] = "U",
          [StatusType.UpstreamUntracked] = "?",
          [StatusType.UpstreamExternal] = "X",
        },
        -- Highlight groups for different status types
        status_hl_group = {
          [StatusType.Added] = "OilVcsStatusAdded",
          [StatusType.Copied] = "OilVcsStatusCopied",
          [StatusType.Deleted] = "OilVcsStatusDeleted",
          [StatusType.Ignored] = "OilVcsStatusIgnored",
          [StatusType.Modified] = "OilVcsStatusModified",
          [StatusType.Renamed] = "OilVcsStatusRenamed",
          [StatusType.TypeChanged] = "OilVcsStatusTypeChanged",
          [StatusType.Unmodified] = "OilVcsStatusUnmodified",
          [StatusType.Unmerged] = "OilVcsStatusUnmerged",
          [StatusType.Untracked] = "OilVcsStatusUntracked",
          [StatusType.External] = "OilVcsStatusExternal",

          [StatusType.UpstreamAdded] = "OilVcsStatusUpstreamAdded",
          [StatusType.UpstreamCopied] = "OilVcsStatusUpstreamCopied",
          [StatusType.UpstreamDeleted] = "OilVcsStatusUpstreamDeleted",
          [StatusType.UpstreamIgnored] = "OilVcsStatusUpstreamIgnored",
          [StatusType.UpstreamModified] = "OilVcsStatusUpstreamModified",
          [StatusType.UpstreamRenamed] = "OilVcsStatusUpstreamRenamed",
          [StatusType.UpstreamTypeChanged] = "OilVcsStatusUpstreamTypeChanged",
          [StatusType.UpstreamUnmodified] = "OilVcsStatusUpstreamUnmodified",
          [StatusType.UpstreamUnmerged] = "OilVcsStatusUpstreamUnmerged",
          [StatusType.UpstreamUntracked] = "OilVcsStatusUpstreamUntracked",
          [StatusType.UpstreamExternal] = "OilVcsStatusUpstreamExternal",
        },
      }

      opts = vim.tbl_deep_extend("force", opts, new_opts)
      return opts
    end,
  },
}
