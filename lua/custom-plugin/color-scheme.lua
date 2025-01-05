return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    -- enabled = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      -- vim.cmd.hi 'Comment gui=none'
    end,
    opts = {
      transparent = true, -- Enable this to disable setting the background color
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { bold = true, italic = true },
        functions = { bold = true },
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = 'dark', -- style for sidebars, see below
        floats = 'dark', -- style for floating windows
      },
      on_colors = function(colors)
        local Util = require 'tokyonight.util'
        -- print(Util.darken(colors.green1, 1))
        colors.green1 = Util.darken(colors.green1, 1)
      end,
      on_highlights = function(hl, c)
        hl.Boolean = { bold = true, fg = c.red }

        hl['@operator'] = { bold = true, fg = c.red }
        -- hl.TelescopeNormal = {
        --   bg = c.bg_dark,
        --   fg = c.fg_dark,
        -- }
      end,
    },
  },
  {
    'scottmckendry/cyberdream.nvim',
    enabled = false,
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd.colorscheme 'cyberdream'
    end,
    opts = {
      transparent = true,
      italic_comments = true,
      hide_fillchars = false,
      borderless_telescope = true,
      terminal_colors = true,
      theme = {
        highlights = {
          WinSeparator = {},
        },
        overrides = function(colors)
          return {
            lualine_c_normal = { bg = colors.bgHighlight },
          }
        end,
        colors = {},
      },
      extensions = {
        lualine = false,
      },
    },
  },

  {
    'rebelot/kanagawa.nvim',
    enabled = false,
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd.colorscheme 'kanagawa-wave'
    end,
    config = function()
      require('kanagawa').setup {
        transparent = true,
      }
    end,
  },

  {
    'rose-pine/neovim',
    priority = 1000,
    enabled = false,
    lazy = false,
    init = function()
      vim.cmd.colorscheme 'rose-pine'
    end,
    config = function()
      require('rose-pine').setup {
        variant = 'moon',
        dark_variant = 'moon',
        enable = {
          terminal = true,
        },
        -- NOTE: work in progress
        palette = {
          moon = {
            rose = '#e65c9a',
            -- base = '#171521',
            -- comments and punctuation
            subtle = '#7b7799',
          },
        },
      }
    end,
  },

  {
    'mhartington/oceanic-next',
    enabled = false,
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd.colorscheme 'OceanicNext'
    end,
  },

  {
    'bluz71/vim-nightfly-colors',
    enabled = false,
    priority = 1000,
    lazy = false,
    init = function()
      -- vim.g.nightflyTransparent = true
      require('nightfly').custom_colors {
        bg = '#011a2e',
      }
      vim.cmd.colorscheme 'nightfly'
    end,
    config = function() end,
  },

  {
    'catppuccin/nvim',
    enabled = false,
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
    config = function()
      require('catppuccin').setup {
        background = {
          dark = 'mocha',
        },
        transparent_background = false,
        integrations = {
          cmp = true,
          -- gitsigns = true,
          nvimtree = false,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
          which_key = false,
        },
      }
    end,
  },
  {
    'navarasu/onedark.nvim',
    enabled = false,
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'darker',
        transparent = true,
        code_style = {
          keywords = 'bold,italic',
          functions = 'bold',
        },
      }
      require('onedark').load()
    end,
  },

  {
    'tiagovla/tokyodark.nvim',
    enabled = false,
    priority = 1000,
    opts = {
      transparent_background = true,
      styles = {
        comments = { italic = true }, -- style for comments
        keywords = { bold = true, italic = true }, -- style for keywords
        identifiers = { italic = true }, -- style for identifiers
        functions = { bold = true }, -- style for functions
        variables = {}, -- style for variables
      },
    },
    init = function()
      vim.cmd.colorscheme 'tokyodark'
    end,
    config = function()
      local set_hl_ns = vim.api.nvim__set_hl_ns or vim.api.nvim_set_hl_ns
      local create_namespace = vim.api.nvim_create_namespace
      local highlight = vim.api.nvim_set_hl

      local M = {}
      local g, cmd = vim.g, vim.cmd

      function M.tokyodark()
        g.tokyodark_transparent_background = true
        pcall(cmd, 'colorscheme tokyodark')
      end

      function _G.custom_highlights()
        local ns = create_namespace 'tokyodark'
        highlight(ns, 'Comment', { fg = '#FF00FF' })
        -- ...
        -- overwrite and add other highlights
        set_hl_ns(ns)
      end

      function M.highlights()
        cmd [[
      augroup custom_theme_highlights
        autocmd!
        au ColorScheme * lua custom_highlights()
        augroup END
    ]]
      end

      function M.setup()
        M.tokyodark()
        M.highlights()
      end

      M.setup()
    end,
  },
}
