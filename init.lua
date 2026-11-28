vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'config.options'
require 'config.lazy'
require 'config.keymaps'
require 'config.autocmds'
require 'config.test_runners'

vim.cmd.colorscheme('gruvbox')
