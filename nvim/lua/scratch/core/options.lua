-- Options are automatically loaded before lazy.nvim startup

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--- netrw tree style -----------------------------------------------------------
-- valid only if netrw is enabled
-- currently, netrw is disabled in favor to nvim-tree plugin
vim.g.netrw_liststyle = 3

--- disalble providers ---------------------------------------------------------
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

--- Common options -------------------------------------------------------------

local opt = vim.opt

opt.scrolloff = 5
opt.sidescrolloff = 20
opt.confirm = false -- Don't ask to save changes before exiting modified buffer

-- opt.clipboard:append("unnamedplus")
opt.clipboard = "unnamedplus,unnamed" -- Sync clipboard between OS and Neovim.
opt.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience

opt.mouse = "a" -- Empty to disable, "a" to enable mouse mode
opt.cursorline = true
opt.showmode = false

opt.undofile = true -- Save undo history

opt.updatetime = 250 -- Swap related
opt.timeoutlen = 500

opt.autoread = true
opt.autowrite = true

opt.hlsearch = true -- Set highlight on search
opt.breakindent = true -- Enable break indent
opt.smartcase = true -- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search

opt.cc = { 81, 101 } -- Column marker
opt.wrap = false -- Don't wrap wide lines

opt.shell = "/bin/zsh"

opt.showcmd = false

-- 2 - Always show status lines
-- 3 - Nvim global status
opt.laststatus = 3

opt.splitbelow = true
-- opt.splitright = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes" -- Keep signcolumn on by default

opt.number = true -- Show line numbers
opt.relativenumber = false -- Disable relative line numbers

opt.backspace = "indent,eol,start"

opt.list = true
opt.listchars = {
    tab = "→ ",
    -- eol = '¶',
    nbsp = "␣",
    trail = "·",
    extends = "»",
}

-- preview substitutions live, as you type!
opt.inccommand = "split"

-- opt.shiftround = true -- Use multiple of shiftwidth when indenting with '<' and '>'
opt.expandtab = true -- Expand <Tab> to spaces in Insert mode
opt.shiftwidth = 4 -- Number of spaces used for each step of (auto)indent
opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for.
opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations

opt.autoindent = true -- automatically set the indent of a new line
opt.copyindent = true -- copy the previous indentation on autoindenting
opt.smartindent = true -- Do smart autoindenting when starting a new line.
opt.cindent = true -- Enables automatic C program indenting.
opt.smarttab = true -- insert tabs on the start of a line according to shiftwidth, not tabstop

-- opt.cino:append("N-s") -- no namespace indent
opt.cino:append(":0") -- case: indent
opt.cino:append("g0") -- public: indent
opt.cino:append("t0") -- function return declaration

-- enable partial c++11 (lambda) support
opt.cino:append("j1")
opt.cino:append("(0") -- unclosed prarntheses
opt.cino:append("ws")
opt.cino:append("Ws")
opt.formatoptions:remove("t") -- don't auto-indent plaintext

opt.shortmess:append("c")

--[[
opt.fillchars = {
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

opt.backup = false
opt.writebackup = false
opt.swapfile = false -- vim.cmd([[ set noswapfile ]])

-- WARNING: `cmdheight=0` is considered experimental. Expect some unwanted behaviour.
-- Some 'shortmess' flags and similar mechanism might fail to take effect,
-- causing unwanted hit-enter prompts.
-- Some informative messages, both from Nvim itself and plugins, will not be displayed.
opt.cmdheight = 0 -- hide cmdline by default

--- fold via tree sitter, opened by default -----------------------------------
-- vim.o.foldenable = false
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

--- set filetype --------------------------------------------------------------
vim.filetype.add({
    extension = {
        frag = "glsl",
        vert = "glsl",
        mm = "objc",
        m = "objc",
    },
})

--- enable line diagnostic ----------------------------------------------------
vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },

    -- virtual_text = {
    --     current_line = true,
    --     virt_text_pos = "eol_right_align",
    -- },
})
