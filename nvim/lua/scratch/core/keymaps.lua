local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>ul", "<cmd>Lazy<cr>", { desc = "Lazy Plugin Manager" })
map("n", "<leader>um", "<cmd>Mason<cr>", { desc = "Mason Manager" })

map("n", "<esc>", "<cmd>nohl<cr>", opts)

map("n", "<leader>wv", "<c-w>v<cr>", { desc = "Split Window Vertically" })
map("n", "<leader>wh", "<c-w>s<cr>", { desc = "Split Window Horizontally" })

map("n", "<leader>wd", "<cmd>close<cr>", { desc = "Close Current Window" })
map("n", "<leader>wD", "<c-w><c-o><cr>", { desc = "Close Other Windows" })

-- Move selected line / block of text in visual mode
map("v", "J", ":m '>+1<cr>gv=gv", opts)
map("v", "K", ":m '<-2<cr>gv=gv", opts)

-- paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')

-- Navigate tabs
map("n", "<right>", ":tabnext<cr>", opts)
map("n", "<left>", ":tabprevious<cr>", opts)

map("n", "<up>", "<cmd>echo 'Use k to move!'<cr>", opts)
map("n", "<down>", "<cmd>echo 'Use j to move!'<cr>", opts)

-- Alias to <esc>
-- map("i", "jk", "<esc>", opts)
-- map("i", "kj", "<esc>", opts)
