return {
  --luacheck: globals Difft
  {
    "ahkohd/difft.nvim",
    keys = {
      {
        "<leader>dJ",
        function()
          if Difft.is_visible() then
            Difft.hide()
          else
            Difft.diff { cmd = "jj diff --no-pager" }
          end
        end,
        desc = "Toggle Difft (JJ)",
      },
      {
        "<leader>dG",
        function()
          if Difft.is_visible() then
            Difft.hide()
          else
            Difft.diff { cmd = "GIT_EXTERNAL_DIFF='difft --color=always' git diff" }
          end
        end,
        desc = "Toggle Difft (Git)",
      },
    },
    config = function()
      require("difft").setup {
        command = "jj diff --no-pager", -- or "GIT_EXTERNAL_DIFF='difft --color=always' git diff"
        layout = "float", -- nil (buffer), "float", or "ivy_taller"
      }
    end,
  },
}
