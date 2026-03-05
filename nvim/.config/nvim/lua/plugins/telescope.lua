return {
  -- fzf extension for telescope with better speed
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = 'make',
  },

  { 'nvim-telescope/telescope-ui-select.nvim' },

  -- fuzzy finder framework
  {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "^./.git/", ".*vendor/", ".*mock.*.go", ".*submodule/" }
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      })

      require('telescope').load_extension('fzf')
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("live_grep_args")
    end,
  },
}
