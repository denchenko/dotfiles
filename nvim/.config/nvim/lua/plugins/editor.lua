return {
  -- hop (easymotion-like)
  {
    'smoka7/hop.nvim',
    version = "*",
    event = "VeryLazy",
    opts = {
      keys = 'etovxqpdygfblzhckisuran'
    },
  },

  -- search selection via *
  { 'bronson/vim-visual-star-search' },

  -- commenting out lines
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require('Comment').setup({
        opleader = {
          block = '<Nop>',
        },
      })
    end,
  },

  -- split/join lines
  { "AndrewRadev/splitjoin.vim", event = "VeryLazy" },

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
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
      })
    end,
  },

  -- unimpaired
  { 'tpope/vim-unimpaired', event = "VeryLazy" },

  -- Alternate between files, such as foo.go and foo_test.go
  {
    "rgroli/other.nvim",
    cmd = { "A", "AV", "AS" },
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

  -- diagnostics list
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
      vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', { desc = "Toggle diagnostics" })
      vim.keymap.set('n', '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', { desc = "Buffer diagnostics" })
      vim.keymap.set('n', '<leader>xq', '<cmd>Trouble qflist toggle<CR>', { desc = "Toggle quickfix" })
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
