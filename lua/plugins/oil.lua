return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    {
      '<leader>ff',
      function()
        require('oil').toggle_float()
      end,
      desc = 'Oil float',
    },
  },
  opts = {
    view_options = { show_hidden = true },
  },
}
