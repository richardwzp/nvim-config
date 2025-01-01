local quit_buffer_gracefully = function()
  require('bufdelete').bufdelete(0, true)
end

return {
  'famiu/bufdelete.nvim',
  keys = {
    { '<c-q>', quit_buffer_gracefully, desc = 'quit current window', silent = true },
  },
}
