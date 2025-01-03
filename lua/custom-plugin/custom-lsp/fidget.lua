return {
  -- provide nice progress bar for lsp
  'j-hui/fidget.nvim',
  config = function()
    require('fidget').setup {
      notification = {
        window = {
          border = 'rounded',
          winblend = 50,
        },
      },
    }
  end,
}
