return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'tokyonight'
    end,
  },
  { 'ellisonleao/gruvbox.nvim', lazy = true, opts = { transparent_mode = true } },
  { 'Shatur/neovim-ayu', lazy = true },
  { 'navarasu/onedark.nvim', lazy = true },
  { 'Mofiqul/dracula.nvim', lazy = true },
  { 'Mofiqul/vscode.nvim', lazy = true },
  { 'doums/darcula', lazy = true },
  { 'rose-pine/neovim', name = 'rose-pine', lazy = true },
  { 'catppuccin/nvim', name = 'catppuccin', lazy = true },
  {
    'baliestri/aura-theme',
    lazy = false,
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. '/packages/neovim')
    end,
  },
}
