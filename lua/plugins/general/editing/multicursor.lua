-- multicursor.lua - Modern multi-cursor editing
return {
  {
    "jake-stewart/multicursor.nvim",
    enabled = true,
    event = "BufRead",
    config = function(_, opts)
      local mc = require "multicursor-nvim"
      mc.setup(opts)

      local map = vim.keymap.set

      -- Mouse support for multi-cursor
      map("n", "<c-leftmouse>", mc.handleMouse, { desc = "Multicursor toggle new cursor on left mouse click" })
      map("n", "<c-leftdrag>", mc.handleMouseDrag, { desc = "Multicursor add cursor on mouse drag" })
      map("n", "<c-leftrelease>", mc.handleMouseRelease, { desc = "Multicursor toggle cursor on left click release" })

      -- Keyboard shortcuts
      map({ "n", "x" }, "<c-q>", mc.toggleCursor, { desc = "Multicursor toggle cursor" })

      -- Custom keymap layer for multicursor mode
      mc.addKeymapLayer(function(layerSet)
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)

      -- Highlight groups for multicursor
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
  },
}
