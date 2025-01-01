return {
  'akinsho/toggleterm.nvim',
  config = function()
    require('toggleterm').setup {}
    vim.keymap.set('n', '\\=', function()
      local term = require 'toggleterm.terminal'
      local terminal = term.get_or_create_term(23)
      if terminal:is_open() then
        terminal:close()
      else
        terminal:open()
        terminal:set_mode 'i'
      end
    end)
  end,
}
