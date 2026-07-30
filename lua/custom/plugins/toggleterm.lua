return {
    'akinsho/toggleterm.nvim',
    version = "*",
    cmd = { 'ToggleTerm', 'ToggleTermToggleAll' },
    keys = {
        { '<leader>t', '<cmd>ToggleTerm size=40 dir=. direction=float<cr>', desc = 'Open floating [T]erminal' },
        {
            '<leader>gg',
            function()
                _G.__lazygit_term = _G.__lazygit_term
                    or require('toggleterm.terminal').Terminal:new { cmd = 'lazygit', direction = 'float', hidden = true }
                _G.__lazygit_term:toggle()
            end,
            desc = '[G]it [G]ui (lazygit)',
        },
    },
    config = function ()
        require('toggleterm').setup {}
    end
}
