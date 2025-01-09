return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  opts = {
    dir = vim.fn.stdpath 'state' .. '/sessions/', -- directory where session files are saved
    -- minimum number of file buffers that need to be open to save
    -- Set to 0 to always save
    need = 1,
    -- branch = true, -- use git branch to save session
  },
  keys = {
    {
      '<leader>pl',
      function()
        require('persistence').load { last = true }
      end,
      desc = 'Load [P]ersisted [L]ast Session',
    },
    {
      '<leader>pc',
      function()
        require('persistence').load()
      end,
      desc = 'Load [P]ersisted [C]urrent Session',
    },
    {
      '<leader>pd',
      function()
        require('persistence').stop()
      end,
      desc = 'Stop [P]ersisting Current Session',
    },
    {
      '<leader>ps',
      function()
        require('persistence').select()
      end,
      desc = 'Select [P]ersisted [S]ession',
    },
  },
}
