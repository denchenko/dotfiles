return {
  { 'tpope/vim-fugitive' },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 500,
        },
        on_attach = function(bufnr)
          local gs = require('gitsigns')
          local opts = { buffer = bufnr }

          vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.nav_hunk('next') end)
            return '<Ignore>'
          end, { buffer = bufnr, expr = true })

          vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.nav_hunk('prev') end)
            return '<Ignore>'
          end, { buffer = bufnr, expr = true })

          vim.keymap.set('n', '<leader>hp', gs.preview_hunk, opts)
          vim.keymap.set('n', '<leader>hs', gs.stage_hunk, opts)
          vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, opts)
          vim.keymap.set('n', '<leader>hb', gs.toggle_current_line_blame, opts)
        end,
      })
    end,
  },
}
