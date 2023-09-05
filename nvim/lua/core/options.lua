vim.o.clipboard = 'unnamedplus,unnamed' -- Sync clipboard between OS and Neovim.
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience

vim.o.mouse = '' -- disable mouse mode, to enable 'a'
vim.o.cursorline = true

vim.o.undofile = true -- Save undo history

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.opt.autoread = true
vim.opt.autowrite = true

vim.o.hlsearch = true         -- Set highlight on search
vim.o.breakindent = true      -- Enable break indent
vim.o.smartcase = true        -- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true       -- Case-insensitive searching UNLESS \C or capital in search

vim.opt.cc = { 81,101 }       -- Column marker
vim.opt.wrap = false          -- Don't wrap wide lines

vim.opt.shell = '/bin/zsh'

vim.opt.shiftround = true     -- Use multiple of shiftwidth when indenting with '<' and '>'
vim.opt.expandtab = true      -- Expand <Tab> to spaces in Insert mode
vim.opt.shiftwidth = 4        -- Number of spaces used for each step of (auto)indent
vim.opt.tabstop = 4           -- Number of spaces a <Tab> in the text stands for
vim.opt.softtabstop = 4       
vim.opt.smartindent = true       

vim.opt.showcmd = true
vim.opt.laststatus = 2        -- Always show status line

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.number = true         -- Line numbers
vim.wo.number = true          -- Line numbers
vim.wo.signcolumn = 'yes'     -- keep signcolumn on by default

vim.opt.shortmess:append("c")
--[[
vim.opt.fillchars = {
    vert = "|",
    fold = " ",
    eob = " ",
    diff = "-",
    msgsep = "+",
    foldopen = " ",
    foldsep = " ",
    foldclose = " ",
}
--]]

vim.cmd [[ set noswapfile ]]

