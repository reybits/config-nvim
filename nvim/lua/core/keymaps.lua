--- Neo Tree ------------------------------------------------------------------
vim.keymap.set('n', '<leader>fo', ':Neotree toggle<cr>', { desc = 'Neotree toggle', silent = true })
vim.keymap.set('n', '<leader>gs', ':Neotree bottom git_status<cr>', { desc = 'Git status', silent = true })

--- navigate vim panes better -------------------------------------------------
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>', { desc = 'Up window', silent = true })
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>', { desc = 'Down window', silent = true })
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>', { desc = 'Left window', silent = true })
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>', { desc = 'Right window', silent = true })

vim.keymap.set('n', '<leader>H', ':nohlsearch<CR>', { desc = 'Hide highlight', silent = true })

--- show / hide the line number for each line ---------------------------------
vim.keymap.set('n', '<leader>n', ':set<Space>nu!<CR>', { desc = 'Toggle line numbers', silent = true })

--- teleport ------------------------------------------------------------------
--[[
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files', silent = true })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep', silent = true })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers', silent = true })
vim.keymap.set('n', '<leader>fz', builtin.current_buffer_fuzzy_find, { desc = 'Fuzzy in buffer', silent = true })
--]]
