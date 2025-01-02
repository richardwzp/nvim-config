return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    enabled = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
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
      transparent = false,
      italic_comments = true,
      hide_fillchars = false,
      borderless_telescope = true,
      terminal_colors = true,
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
      -- require('nightfly').palette
      require('nightfly').custom_colors {
        bg = '#011a2e',
      }
      vim.cmd.colorscheme 'nightfly'
    end,
    config = function() end,
  },

  {
    'catppuccin/nvim',
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
        transparent_background = true,
        integrations = {
          cmp = true,
          -- gitsigns = true,
          nvimtree = true,
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
}
