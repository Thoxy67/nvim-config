-- grug-far.lua - Another find and replace tool
return {
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    event = "BufReadPost",
    opts = {},
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "grug_far")
      local map = vim.keymap.set

      require("grug-far").setup(opts)

      -- Function to check if grug-far is open
      local is_grugfar_open = function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          local buf_name = vim.api.nvim_get_option_value("filetype", { buf = buf })
          if buf_name and buf_name == "grug-far" then
            return true
          end
        end
        return false
      end

      -- Toggle grug-far window
      local toggle_grugfar = function()
        local open = is_grugfar_open()
        if open then
          require "grug-far/actions/close"()
        else
          vim.cmd "GrugFar"
        end
      end

      map("n", "<leader>gr", function()
        toggle_grugfar()
      end, { desc = "Toggle GrugFar" })
    end,
  },
}
