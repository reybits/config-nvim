local map = vim.keymap.set

map("n", "<leader>ul", "<cmd>Lazy<cr>", { desc = "Lazy Plugin Manager" })
map("n", "<leader>um", "<cmd>Mason<cr>", { desc = "Mason Manager" })

map("n", "<esc>", "<cmd>nohl<cr>", { desc = "Clear Search Highlights" })

map("n", "<leader>wv", "<c-w>v<cr>", { desc = "Split Window Vertically" })
map("n", "<leader>wh", "<c-w>s<cr>", { desc = "Split Window Horizontally" })

map("n", "<leader>wd", "<cmd>close<cr>", { desc = "Close Current Window" })
map("n", "<leader>wD", "<c-w><c-o><cr>", { desc = "Close Other Windows" })
