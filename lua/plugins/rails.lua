return {
  'tpope/vim-rails',
  lazy = false,
  cond = function()
    return vim.fn.filereadable(vim.fn.getcwd() .. '/bin/rails') == 1
  end,
}
