return {'norcalli/nvim-colorizer.lua', opt = true,
   cmd = {'ColorizerAttachToBuffer', 'ColorizerDetachFromBuffer'},
   setup = function()
      vim.g.colorizer_auto_setup = 1
   end,
   config = function()
      require('colorizer').setup()
   end,
   event = {'BufReadPre', 'BufNewFile', 'BufEnter', 'VimEnter', 'ColorScheme'},
   keys = {{'n', '<leader>z', ':ColorizerToggle<CR>'}},
   requires = {'nvim-lua/plenary.nvim'},
   module = {'colorizer'},
}
