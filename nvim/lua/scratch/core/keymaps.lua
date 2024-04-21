local map = vim.keymap.set

map("n", "<leader>ul", "<cmd>Lazy<cr>", { desc = "Lazy plugin manager" })
map("n", "<leader>um", "<cmd>Mason<cr>", { desc = "Mason manager" })

map("n", "<esc>", "<cmd>nohl<cr>", { desc = "Clear search highlights" })

map("n", "<leader>wv", "<c-w>v<cr>", { desc = "Split window vertically" })
map("n", "<leader>wh", "<c-w>s<cr>", { desc = "Split window horizontally" })

map("n", "<leader>wd", "<cmd>close<cr>", { desc = "Close current window" })
map("n", "<leader>wD", "<c-w><c-o><cr>", { desc = "Close other windows" })
