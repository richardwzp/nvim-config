return {
  -- provide nice progress bar for lsp
  'j-hui/fidget.nvim',
  config = function()
    require('fidget').setup {
      progress = {
        ignore = {
          function(msg)
            return msg.lsp_client.name == 'jdtls' and (string.find(msg.title, 'Publish Diagnostics') or string.find(msg.title, 'Validate documents'))
          end,
        },
        ignore_done_already = false, -- Ignore new tasks that are already complete
        display = {
          done_ttl = 3,
        },
      },
      notification = {
        filter = vim.log.levels.INFO, -- Minimum notifications level
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
