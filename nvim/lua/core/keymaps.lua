local options = { silent = true }

--- navigate vim panes better -----------------------------------------------
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>', options)
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>', options)
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>', options)
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>', options)

options["desc"] = "Hide highlight"
vim.keymap.set('n', '<leader>H', ':nohlsearch<CR>', options)

--- show / hide the line number for each line -------------------------------
options["desc"] = "Toggle line numbers"
vim.keymap.set('n', '<leader>n', ':set<Space>nu!<CR>', options)

--- teleport ----------------------------------------------------------------
local builtin = require('telescope.builtin')
options["desc"] = "Find files"
vim.keymap.set('n', '<leader>ff', builtin.find_files, options)
options["desc"] = "Live grep"
vim.keymap.set('n', '<leader>fg', builtin.live_grep, options)
options["desc"] = "Buffers"
vim.keymap.set('n', '<leader>fb', builtin.buffers, options)
options["desc"] = "Fuzzy in buffer"
vim.keymap.set('n', '<leader>fz', builtin.current_buffer_fuzzy_find, options)
