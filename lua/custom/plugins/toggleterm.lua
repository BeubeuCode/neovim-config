vim.keymap.set('n', '<leader>t', ':ToggleTerm size=40 dir=. direction=float<cr>', { desc = 'Open floating [T]erminal'})
return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
    },
    config = function ()
        require('toggleterm').setup {}
    end
}

