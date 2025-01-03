local options = {
  hover = {
    enabled = true,
    delay = 200,
    reveal = { 'close' },
  },
  mode = 'buffers', -- set to "tabs" to only show tabpages instead
  numbers = 'none',
  close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
  right_mouse_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
  left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
  middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
  -- NOTE: this plugin is designed with this icon in mind,
  -- and so changing this is NOT recommended, this is intended
  -- as an escape hatch for people who cannot bear it for whatever reason
  -- the following line is deprecated, in favor of indicator
  -- indicator_icon = '▎',
  indicator = {
    style = 'none',
    icon = '|',
  },
  buffer_close_icon = '',
  modified_icon = '●',
  close_icon = '',
  left_trunc_marker = '',
  right_trunc_marker = '',
  --- name_formatter can be used to change the buffer's label in the bufferline.
  --- Please note some names can/will break the
  --- bufferline so use this at your discretion knowing that it has
  --- some limitations that will *NOT* be fixed.
  name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
    -- remove extension from markdown files for example
    if buf.name:match '%.md' then
      return vim.fn.fnamemodify(buf.name, ':t:r')
    end
  end,
  max_name_length = 18,
  max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
  tab_size = 18,
  diagnostics = 'nvim_lsp',
  diagnostics_update_in_insert = false,
  -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
  diagnostics_indicator = function(count, level, diagnostics_dict, context)
    return '(' .. count .. ')'
  end,
  -- NOTE: this will be called a lot so don't do any heavy processing here
  custom_filter = function(buf_number, buf_numbers)
    -- filter out filetypes you don't want to see
    if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
      return true
    end
    -- filter out by buffer name
    if vim.fn.bufname(buf_number) ~= '<buffer-name-I-dont-want>' then
      return true
    end
    -- filter out based on arbitrary rules
    -- e.g. filter out vim wiki buffer from tabline in your work repo
    if vim.fn.getcwd() == '<work-repo>' and vim.bo[buf_number].filetype ~= 'wiki' then
      return true
    end
    -- filter out by it's index number in list (don't show first buffer)
    if buf_numbers[1] ~= buf_number then
      return true
    end
  end,
  offsets = { { filetype = 'NvimTree', text = 'File Explorer', text_align = 'left' } },
  color_icons = true, -- whether or not to add the filetype icon highlights
  -- @deprecated
  -- show_buffer_icons = true , -- disable filetype icons for buffers
  show_buffer_close_icons = true,
  -- show_buffer_default_icon = true , -- whether or not an unrecognised filetype should show a default icon
  get_element_icon = function(element)
    -- element consists of {filetype: string, path: string, extension: string, directory: string}
    -- This can be used to change how bufferline fetches the icon
    -- for an element e.g. a buffer or a tab.
    -- e.g.
    local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
    return icon, hl
    -- or
    -- local custom_map = {my_thing_ft: {icon = "my_thing_icon", hl}}
    -- return custom_map[element.filetype]
  end,

  show_close_icon = true,
  show_tab_indicators = true,
  persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
  -- can also be a table containing 2 custom separators
  -- [focused and unfocused]. eg: { '|', '|' }
  separator_style = { '', '' },
  enforce_regular_tabs = true,
  always_show_bufferline = true,
  sort_by = 'insert_after_current',
}

return {
  'akinsho/bufferline.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  dependencies = 'nvim-tree/nvim-web-devicons',
  keys = {
    { '<S-u>', ':BufferLineCyclePrev<CR>', desc = 'left buffer window', silent = true },
    { '<S-i>', ':BufferLineCycleNext<CR>', desc = 'right buffer window', silent = true },
  },
  config = function()
    local selected_color = '#363636'
    local separator_color = '#ab0a2d'
    require('bufferline').setup {
      options = options,

      highlights = {

        tab_selected = {
          bg = selected_color,
        },
        separator = {
          fg = separator_color,
        },
        separator_visible = {
          fg = separator_color,
        },
        separator_selected = {
          fg = separator_color,
        },
        tab_separator_selected = {
          underline = true,
        },
        close_button_selected = {
          bg = selected_color,
        },
        buffer_selected = {
          bg = selected_color,
          bold = true,
        },
        numbers_selected = {
          bg = selected_color,
        },
        diagnostic_selected = {
          bg = selected_color,
        },
        hint_diagnostic_selected = {
          bg = selected_color,
        },
        hint_selected = {
          bg = selected_color,
        },

        info_selected = {
          bg = selected_color,
        },
        info_diagnostic_selected = {
          bg = selected_color,
        },
        warning_selected = {
          bg = selected_color,
        },
        warning_diagnostic_selected = {
          bg = selected_color,
        },
        error_selected = {
          bg = selected_color,
        },
        error_diagnostic_selected = {
          bg = selected_color,
        },
        modified_selected = {
          bg = selected_color,
        },
        duplicate_selected = {
          bg = selected_color,
        },
        indicator_selected = {
          bg = selected_color,
        },
        pick_selected = {
          bg = selected_color,
        },
      },
    }
  end,
}
