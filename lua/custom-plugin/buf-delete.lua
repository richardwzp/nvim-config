local quit_buffer_gracefully = function()
  local buf_delete = require 'bufdelete'

  buf_delete.bufdelete(0, true)
  -- if there's more than one window, that means there's split going on. simply close it.
  local win_count = #vim.api.nvim_tabpage_list_wins(0)
  local suc, res = pcall(require, 'nvim-tree.api')
  -- don't count nvim tree extension
  if suc and res.tree.is_visible() then
    win_count = win_count - 1
  end
  if win_count > 1 then
    vim.api.nvim_win_hide(0)
  end
end

return {
  'famiu/bufdelete.nvim',
  keys = {
    { '<c-q>', quit_buffer_gracefully, desc = 'quit current window', silent = true },
  },
}
