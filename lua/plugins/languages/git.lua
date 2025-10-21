-- ============================================================================
-- GIT LANGUAGE SUPPORT
-- lua/plugins/languages/git.lua
-- ============================================================================
-- Git file syntax highlighting and editing support featuring:
-- - Treesitter parsers for all Git configuration file types
-- - Enhanced syntax highlighting for commits, config, rebase, and ignore files
-- ============================================================================

return {
  -- ==================== TREESITTER SUPPORT ====================
  -- Treesitter parsers for Git-related file formats
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "git_config",     -- .gitconfig files
        "gitcommit",      -- Git commit messages (COMMIT_EDITMSG)
        "git_rebase",     -- Interactive rebase files (git-rebase-todo)
        "gitignore",      -- .gitignore files
        "gitattributes",  -- .gitattributes files
      },
    },
  },
}
