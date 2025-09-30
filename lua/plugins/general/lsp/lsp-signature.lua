-- lsp-signature.lua - Function signature help
return {
  {
    "ray-x/lsp_signature.nvim",
    event = "LspAttach",
    config = function()
      local disabled_filetypes = { "svelte" }

      -- Create autocmd to handle per-filetype enabling/disabling
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local should_disable = vim.tbl_contains(disabled_filetypes, ft)

          if not should_disable then
            require("lsp_signature").on_attach({
              bind = true,
              handler_opts = {
                border = "rounded",
              },
            }, args.buf)
          end
        end,
      })
    end,
  },
}
