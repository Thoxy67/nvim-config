-- ============================================================================
-- QMK/ZMK KEYBOARD FIRMWARE SUPPORT
-- lua/plugins/languages/qmk.lua
-- ============================================================================
-- QMK/ZMK development environment featuring:
-- - Visual keymap layout formatting with qmk.nvim
-- - Automatic detection and formatting for specific keyboard layouts
-- - Support for both QMK (C-based) and ZMK (devicetree-based) firmware
-- - Treesitter support for devicetree syntax
-- ============================================================================

return {
  -- ==================== QMK.NVIM PLUGIN ====================
  -- Visual keymap formatter that aligns keycode definitions to match
  -- physical keyboard layout for easier visualization and editing
  {
    "codethread/qmk.nvim",
    ft = { "c", "keymap", "dts" }, -- Activate for C files, keymap files, and devicetree
    opts = {
      name = "dumb", -- Default layout name (overridden by autocmds)
      layout = { "x x" }, -- Default minimal layout (overridden by autocmds)
    },
    config = function(_, opts)
      local group = vim.api.nvim_create_augroup("MyQMK", {})

      -- ==================== GMMK2 KEYBOARD LAYOUT ====================
      -- Auto-configure for GMMK2 keyboard keymaps
      -- Pattern matches files in gmmk2/*/keymap.c directories
      vim.api.nvim_create_autocmd("BufEnter", {
        desc = "Format gmmk keymap",
        group = group,
        pattern = "gmmk2/*/keymap.c",
        callback = function()
          require("qmk").setup {
            name = "LAYOUT", -- LAYOUT macro name used in keymap.c
            auto_format_pattern = "*/keymap.c", -- Auto-format on save for keymap files
            -- Layout representation:
            -- 'x' = key position, '_' = gap/empty space
            -- '^' = merge adjacent keys (like spacebar)
            layout = {
              "x x x x x x x x x x x x x _ x _ _ x x x x _", -- Number row + F-keys
              "x x x x x x x x x x x x x _ x _ _ x x x x _", -- Top alpha row
              "x x x x x x x x x x x x x _ x _ _ x x x x _", -- Home row
              "x x x x x x x x x x x x x _ _ _ _ x x x _ _", -- Bottom alpha row
              "x x x x x x x x x x x x x _ _ x _ x x x x _", -- Modifier row
              "x x x xxxxxx^xxxxxx x x x _ x x x _ x x _ _", -- Space bar (merged keys)
            },
            variant = "qmk", -- QMK firmware variant (C-based)
          }
        end,
      })

      -- ==================== SOFLE KEYBOARD LAYOUT ====================
      -- Auto-configure for Sofle split keyboard keymaps (ZMK firmware)
      -- Pattern matches files ending with sofle.keymap
      vim.api.nvim_create_autocmd("BufEnter", {
        desc = "Format sofle keymap",
        group = group,
        pattern = "*sofle.keymap",
        callback = function()
          require("qmk").setup {
            name = "LAYOUT_preonic_grid", -- Layout macro name in devicetree
            -- Split keyboard layout (left half _ gap _ right half)
            layout = {
              "_ x x x x x x _ x x x x x x x", -- Top row (left split _ gap _ right split)
              "_ x x x x x x _ x x x x x x x", -- Second row
              "_ x x x x x x _ x x x x x x x", -- Home row
              "_ x x x x x x _ x x x x x x x", -- Fourth row
              "_ x x x x x x _ x x x x x x _", -- Bottom row with encoders
            },
            variant = "zmk", -- ZMK firmware variant (devicetree-based)
          }
        end,
      })

      -- Apply default configuration for other keyboards
      require("qmk").setup(opts)
    end,
  },

  -- ==================== TREESITTER SUPPORT ====================
  -- Devicetree parser for ZMK firmware keymap files
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "devicetree" }, -- ZMK uses Zephyr devicetree format (.keymap, .dts files)
    },
  },
}
