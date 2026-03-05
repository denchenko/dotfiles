return {
  -- hop (easymotion-like)
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {
      keys = 'etovxqpdygfblzhckisuran'
    },
  },

  -- search selection via *
  { 'bronson/vim-visual-star-search' },

  -- commenting out lines
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup({
        opleader = {
          block = '<Nop>',
        },
      })
    end,
  },

  -- split/join lines
  { "AndrewRadev/splitjoin.vim" },

  -- save my last cursor position
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true,
      })
    end,
  },

  -- autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  },

  -- unimpaired
  { 'tpope/vim-unimpaired' },

  -- Alternate between files, such as foo.go and foo_test.go
  {
    "rgroli/other.nvim",
    config = function()
      require("other-nvim").setup({
        mappings = {
          "rails",
          {
            pattern = "(.*).go$",
            target = "%1_test.go",
            context = "test",
          },
          {
            pattern = "(.*)_test.go$",
            target = "%1.go",
            context = "file",
          },
        },
      })

      vim.api.nvim_create_user_command('A', function(opts)
        require('other-nvim').open(opts.fargs[1])
      end, { nargs = '*' })

      vim.api.nvim_create_user_command('AV', function(opts)
        require('other-nvim').openVSplit(opts.fargs[1])
      end, { nargs = '*' })

      vim.api.nvim_create_user_command('AS', function(opts)
        require('other-nvim').openSplit(opts.fargs[1])
      end, { nargs = '*' })
    end,
  },

  -- claude-code
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("claude-code").setup()
    end,
  },
}
