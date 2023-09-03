-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 4           -- number of spaces a <Tab> in the text stands for
vim.opt.shiftwidth = 4        -- number of spaces used for each step of (auto)indent
vim.opt.shiftround = true     -- use multiple of shiftwidth when indenting with '<' and '>'
vim.opt.expandtab = true      -- expand <Tab> to spaces in Insert mode

vim.opt.wrap = false          -- don't wrap wide lines
vim.opt.cc = { 81,101 }       -- column marker
-- vim.opt.laststatus = 2        -- always show status line

vim.wo.number = true -- line numbers

vim.cmd [[ set noswapfile ]]

