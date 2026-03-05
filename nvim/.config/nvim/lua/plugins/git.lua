return {
  { 'tpope/vim-fugitive', cmd = { "Git", "G", "Gvdiffsplit" } },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        current_line_blame = false,
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

          vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
          vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
          vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
          vim.keymap.set('n', '<leader>hb', gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle line blame" })
        end,
      })
    end,
  },
}
