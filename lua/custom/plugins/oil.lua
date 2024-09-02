return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function ()
    local oil = require('oil')
    oil.setup({})
    vim.keymap.set('n', '<leader>ff', function()
      oil.toggle_float(nil)
    end, {})
  end
}
