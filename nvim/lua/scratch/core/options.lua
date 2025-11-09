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

--- common options -------------------------------------------------------------

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 20
vim.opt.confirm = false -- Don't ask to save changes before exiting modified buffer

vim.opt.clipboard:append("unnamedplus") -- Sync clipboard between OS and Neovim.
vim.opt.completeopt = { "menuone", "noselect" } -- Set completeopt to have a better completion experience

vim.opt.mouse = "a" -- Empty to disable, "a" to enable mouse mode
vim.opt.cursorline = true
vim.opt.showmode = false

vim.opt.undofile = true -- Save undo history

vim.opt.updatetime = 250 -- Swap related
vim.opt.timeoutlen = 500

vim.opt.autoread = true
vim.opt.autowrite = true

vim.opt.hlsearch = true -- Set highlight on search
vim.opt.breakindent = true -- Enable break indent
vim.opt.smartcase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search

vim.opt.cc = { 81, 101 } -- Column marker
vim.opt.wrap = false -- Don't wrap wide lines

-- INFO: Commented out to use the default shell (vim.env.SHELL)
-- vim.opt.shell = "/bin/zsh"

vim.opt.showcmd = false

-- 2 - Always show status lines
-- 3 - Nvim global status
vim.opt.laststatus = 3

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default

vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = false -- Disable relative line numbers

vim.opt.backspace = { "indent", "eol", "start" }

vim.opt.list = true
vim.opt.listchars = {
    tab = "→ ",
    -- eol = '¶',
    nbsp = "␣",
    trail = "·",
    extends = "»",
}

-- preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- vim.opt.shiftround = true -- Use multiple of shiftwidth when indenting with '<' and '>'
vim.opt.expandtab = true -- Expand <Tab> to spaces in Insert mode
vim.opt.shiftwidth = 4 -- Number of spaces used for each step of (auto)indent
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for.
vim.opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations

vim.opt.autoindent = true -- automatically set the indent of a new line
vim.opt.copyindent = true -- copy the previous indentation on autoindenting
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line.
vim.opt.cindent = true -- Enables automatic C program indenting.
vim.opt.smarttab = true -- insert tabs on the start of a line according to shiftwidth, not tabstop

-- vim.opt.cino:append("N-s") -- no namespace indent
vim.opt.cino:append(":0") -- case: indent
vim.opt.cino:append("g0") -- public: indent
vim.opt.cino:append("t0") -- function return declaration

-- enable partial c++11 (lambda) support
vim.opt.cino:append("j1")
vim.opt.cino:append("(0") -- unclosed prarntheses
vim.opt.cino:append("ws")
vim.opt.cino:append("Ws")
vim.opt.formatoptions:remove("t") -- don't auto-indent plaintext

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

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false -- vim.cmd([[ set noswapfile ]])

-- WARNING: `cmdheight=0` is considered experimental. Expect some unwanted behaviour.
-- Some 'shortmess' flags and similar mechanism might fail to take effect,
-- causing unwanted hit-enter prompts.
-- Some informative messages, both from Nvim itself and plugins, will not be displayed.
-- INFO: The option `cmdheight = 0` is disabled due to incorrect Neovim behavior
-- in some cases, such as mappings for 'J' and 'K'.
-- vim.opt.cmdheight = 0 -- hide cmdline by default

--- fold via tree sitter, opened by default ------------------------------------
-- vim.o.foldenable = false
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

--- set filetype ---------------------------------------------------------------
vim.filetype.add({
    extension = {
        frag = "glsl",
        vert = "glsl",
        mm = "objc",
        m = "objc",
    },
})

--- enable line diagnostic -----------------------------------------------------
vim.diagnostic.config({
    underline = false,

    virtual_lines = {
        current_line = true,
    },

    -- virtual_text = {
    --     current_line = true,
    --     virt_text_pos = "eol_right_align",
    -- },
})
