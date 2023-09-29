-- return {}
return {
  'akinsho/bufferline.nvim',
  config = function()
    require('bufferline').setup {
      options = {
        diagnostics = "nvim_lsp",
        offsets = {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "left",
          separator = true,
        },
      },
    }
  end
}
