return {
  -- provide nice progress bar for lsp
  'j-hui/fidget.nvim',
  config = function()
    require('fidget').setup {
      notification = {
        window = {
          border = 'rounded',
          winblend = 50,
          max_width = 0, -- Maximum width of the notification window
          max_height = 5, -- Maximum height of the notification window
        },
      },
      integration = {
        ['nvim-tree'] = {
          enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
        },
      },
    }
  end,
}
