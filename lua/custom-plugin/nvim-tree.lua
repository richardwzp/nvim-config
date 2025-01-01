-- directly from repo readme
local function my_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts 'Up')
  vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
end

return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<Leader>e', ':NvimTreeToggle<CR>', desc = 'togglet nvim tree', silent = true },
  },
  sort = {
    sorter = 'case_sensitive',
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  on_attach = my_on_attach,
  config = function()
    -- run NvimTreeHiTest to show all related highlight group
    vim.api.nvim_set_hl(0, 'NvimTreeGitDirty', { fg = '#1b8ecc' })
    vim.api.nvim_set_hl(0, 'NvimTreeGitNew', { fg = '#22c7a0' })
    require('nvim-tree').setup {
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        severity = {
          min = vim.diagnostic.severity.WARN,
        },
      },
      renderer = {
        highlight_git = 'name',
        highlight_diagnostics = 'name',
      },
    }
  end,
}
