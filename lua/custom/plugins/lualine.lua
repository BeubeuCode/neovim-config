-- return {
--     'nvim-lualine/lualine.nvim',
--     opts = {
--         options = {
--             icons_enabled = true,
--             theme = 'neovim_purple',
--         },
--         sections = {
--             lualine_a = {
--                 {
--                     'filename',
--                     path = 1,
--                 }
--             }
--         }
--     }
-- }
return {
    {
        'nvim-lualine/lualine.nvim',
        lazy = true,
        event = { "BufReadPost", "BufAdd", "BufNewFile" },
        dependencies = {
            { 'nvim-tree/nvim-web-devicons', opt = true },
            'avocadeys/nvim-lualine-components',
        },
        opts = {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = "",
                section_separators = {
                    left = '', right = ''
                },
                disabled_filetypes = {
                    statusline = {
                        'alpha'
                    },
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {
                    {
                        'mode',
                        separator = {
                            left = '', right = ''
                        },
                    },
                },
                lualine_b = {
                    {
                        'branch', icon = '󰘬',
                    },
                    {
                        'diff',
                        symbols = {
                            added = ' ', modified = ' ', removed = ' '
                        },
                    }
                },
                lualine_c = {
                    {
                        'filename',
                        path = 1,
                        file_status = true,
                    },
                },
                lualine_x = {
                    'encoding', 'fileformat',
                },
                lualine_y = {
                    { 'lsp_servers' },
                },
                lualine_z = {
                    'progress',
                    {
                        'location',
                        separator = {
                            right = ''
                        },
                    },
                }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {
                    'filename',
                },
                lualine_x = {
                    'location'
                },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {
                "nvim-tree"
            }
        }
    }
}
-- return {
--     -- Set lualine as statusline
--     'nvim-lualine/lualine.nvim',
--     -- See `:help lualine.txt`
--     opts = {
--         options = {
--             icons_enabled = true,
--             theme = 'auto',
--             component_separators = '|',
--             section_separators = '',
--         },
--         sections = {
--             lualine_c = {
--                 {
--                     'filename',
--                     file_status = true,
--                     path = 1
--                 }
--             }
--         }
--     },
-- }