return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-cmdline',
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    luasnip.config.setup {}
    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup {
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        format = require('lspkind').cmp_format {
          mode = 'symbol_text',
          menu = { nvim_lsp = '[LSP]', luasnip = '[Snip]', path = '[Path]', buffer = '[Buf]' },
        },
      },
      experimental = { ghost_text = true },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            return cmp.select_next_item()
          end
          if luasnip.expand_or_jumpable() then
            return luasnip.expand_or_jump()
          end
          fallback()
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            return cmp.select_prev_item()
          end
          if luasnip.jumpable(-1) then
            return luasnip.jump(-1)
          end
          fallback()
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
      },
    }

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = 'buffer' } },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
    })
  end,
}
