-- spectre.lua - Advanced find and replace using regex
return {
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    keys = {
      {
        "<leader>fR",
        function()
          require("spectre").open()
        end,
        desc = "Search and Replace (Spectre)",
      },
    },
    opts = {},
  },
}
