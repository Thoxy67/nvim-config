-- ============================================================================
-- OCAML LANGUAGE SUPPORT
-- lua/plugins/languages/ocaml.lua
-- ============================================================================

vim.lsp.config.ocamllsp = {
  filetypes = {
    "ocaml",
    "ocaml.menhir",
    "ocaml.interface",
    "ocaml.ocamllex",
    "reason",
    "dune",
    "ml",
    "mli",
    "cmi",
    "cmo",
    "cmx",
    "cma",
    "cmxa",
    "cmxs",
    "cmt",
    "cmti",
    "opam",
  },
  root_markers = {
    function(name)
      return name:match ".*%.opam$"
    end,
    "esy.json",
    "package.json",
    ".git",
    "dune-project",
    "dune-workspace",
    function(name)
      return name:match ".*%.ml$"
    end,
  },
}

vim.lsp.enable { "ocamllsp" }

return {
  -- Treesitter support for OCaml
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ocaml" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ocamllsp = {
          filetypes = {
            "ocaml",
            "ocaml.menhir",
            "ocaml.interface",
            "ocaml.ocamllex",
            "reason",
            "dune",
            "ml",
            "mli",
            "cmi",
            "cmo",
            "cmx",
            "cma",
            "cmxa",
            "cmxs",
            "cmt",
            "cmti",
            "opam",
          },
          root_markers = {
            function(name)
              return name:match ".*%.opam$"
            end,
            "esy.json",
            "package.json",
            ".git",
            "dune-project",
            "dune-workspace",
            function(name)
              return name:match ".*%.ml$"
            end,
          },
        },
      },
    },
  },
}
