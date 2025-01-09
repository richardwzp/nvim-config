-- [[ basic keymaps ]]
--  see `:help vim.keymap.set()`

-- clear highlights on search when pressing <esc> in normal mode
--  see `:help hlsearch`
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')

-- diagnostic keymaps
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'open [D]iagnostic [Q]uickfix list' })

-- exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. otherwise, you normally need to press <c-\><c-n>, which
-- is not what someone will guess without a bit more experience.
--
-- note: this won't work in all terminal emulators/tmux/etc. try your own mapping
-- or just use <c-\><c-n> to exit terminal mode
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'exit terminal mode' })

-- tip: disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "use h to move!!"<cr>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "use l to move!!"<cr>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "use k to move!!"<cr>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "use j to move!!"<cr>')

-- keybinds to make split navigation easier.
--  use ctrl+<hjkl> to switch between windows
--
--  see `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<c-h>', '<c-w><c-h>', { desc = 'move focus to the left window' })
vim.keymap.set('n', '<c-l>', '<c-w><c-l>', { desc = 'move focus to the right window' })
vim.keymap.set('n', '<c-j>', '<c-w><c-j>', { desc = 'move focus to the lower window' })
vim.keymap.set('n', '<c-k>', '<c-w><c-k>', { desc = 'move focus to the upper window' })

-- split window
vim.keymap.set('n', '<c-x>', '<c-w><c-s>', { desc = 'split window horizontally' })
vim.keymap.set('n', '<c-v>', '<c-w><c-v>', { desc = 'split window vertically' })

-- other window adjustement
vim.keymap.set('n', 'T', '<c-w>T', { desc = 'break out into a new tab' })
vim.keymap.set('n', '+', '<c-w>>', { desc = 'increase width' })
vim.keymap.set('n', '_', '<c-w><', { desc = 'decrease width' })
vim.keymap.set('n', '<M-=>', '<c-w>+', { desc = 'increase height' })
vim.keymap.set('n', '<M-->', '<c-w>-', { desc = 'decrease height' })

-- more custom stuff
vim.keymap.set('n', '<c-s>', ':w<cr>', { desc = 'save current window' })

-- move entire lines up and down
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", { desc = 'move selected up in visual' })
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", { desc = 'move selected down in visual' })

vim.keymap.set({ 'n' }, '<M-k>', ':m .-2<CR>==', { desc = 'move line up' })
vim.keymap.set({ 'n' }, '<m-j>', ':m .+1<CR>==', { desc = 'move line down' })

vim.keymap.set({ 'i' }, '<M-k>', '<ESC>:m .-2<CR>==', { desc = 'move line up' })
vim.keymap.set({ 'i' }, '<M-j>', '<ESC>:m .+1<CR>==', { desc = 'move line down' })

-- window quit
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>q', ':q<CR>', { desc = '[Q]uit window' })

-- run lua code
vim.keymap.set({ 'v' }, '<leader>oo', ":'<,'>lua<CR>", { desc = 'run selected lua code' })
vim.keymap.set({ 'n' }, '<leader>oo', "V:'<,'>lua<CR>", { desc = 'run selected lua code' })
vim.keymap.set({ 'n' }, '<leader>of', ':%lua<CR>', { desc = 'run lua code on the page' })

-- [[ basic autocommands ]]
--  see `:help lua-guide-autocommands`

-- highlight when yanking (copying) text
--  try it with `yap` in normal mode
--  see `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('textyankpost', {
  desc = 'highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
