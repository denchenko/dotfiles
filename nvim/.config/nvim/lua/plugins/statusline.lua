return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("lualine").setup({
        options = { theme = 'nightfox' },
        sections = {
          lualine_b = { 'branch', 'diff' },
          lualine_c = {
            {
              'filename',
              file_status = true,
              path = 2,
            }
          },
          lualine_x = { 'diagnostics', 'filetype' },
        }
      })
    end,
  },
}
