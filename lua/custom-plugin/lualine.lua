return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    local auto_theme = require 'lualine.themes.auto'
    local white = '#ffffff'

    auto_theme.normal.a.bg = '#1d6cb5'
    auto_theme.normal.a.fg = white

    auto_theme.insert.a.bg = '#391db5'
    auto_theme.insert.a.fg = white

    auto_theme.visual.a.bg = '#bd5eff'
    auto_theme.visual.a.fg = white

    if auto_theme.normal.y == nil then
      auto_theme.normal.y = {}
    end
    auto_theme.normal.y.fg = white

    local tame_bg = '#2a2f33'
    for _, con in ipairs { 'normal', 'visual', 'insert' } do
      for _, letter in ipairs { 'b', 'c', 'x', 'y', 'z' } do
        if auto_theme[con][letter] ~= nil then
          auto_theme[con][letter].bg = tame_bg
        end
      end
    end
    auto_theme.inactive = {
      c = {
        bg = tame_bg,
      },
    }
    require('lualine').setup {
      options = {
        themable = true,
        icons_enabled = true,
        theme = auto_theme,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        -- refresh = {
        --   statusline = 1000,
        --   tabline = 1000,
        --   winbar = 1000,
        -- },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          {
            'branch',
            icon = '',
            -- source = function()
            --   local gitsigns = vim.b.gitsigns_status_dict
            --   if gitsigns then
            --     return {
            --       added = gitsigns.added,
            --       modified = gitsigns.changed,
            --       removed = gitsigns.removed,
            --     }
            --   end
            -- end,
          },
          { 'diff' },
          -- {
          --   'diagnostics',
          --   symbols = {
          --     error = ' ', -- xf659
          --     warn = ' ', -- xf529
          --     info = ' ', -- xf7fc
          --     hint = ' ', -- xf835
          --   },
          -- },
        },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
