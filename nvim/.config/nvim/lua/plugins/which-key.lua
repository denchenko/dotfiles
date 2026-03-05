return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>t", group = "test/terminal" },
        { "<leader>d", group = "diagnostics" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lint/grep" },
        { "<leader>x", group = "trouble" },
        { "<leader>c", group = "code action/lens" },
        { "<leader>r", group = "rename/replace" },
        { "<leader>h", group = "git hunks" },
        { "<leader><leader>", group = "hop" },
      },
    },
  },
}
