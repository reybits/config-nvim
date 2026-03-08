--------------------------------------------------------------------------------

local ToggleOption = require("scratch.core.toggleopt")

--------------------------------------------------------------------------------

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local desc = function(desc, override)
    local merged = override or opts
    merged.desc = desc
    return merged
end

--------------------------------------------------------------------------------

--- plugins and tools managers -------------------------------------------------
map("n", "<leader>tl", "<cmd>Lazy<cr>", desc("Lazy Manager"))
map("n", "<leader>tm", "<cmd>Mason<cr>", desc("Mason Manager"))

--- hide highligting by <esc> --------------------------------------------------
map("n", "<esc>", "<cmd>nohl<cr>", desc("Clear Highligted text"))
map("n", "<c-[>", "<cmd>nohl<cr>", desc("Clear Highligted text"))

--- window related stuff -------------------------------------------------------
map("n", "<leader>wv", "<c-w>v<cr>", desc("Split Window Vertically"))
map("n", "<leader>wh", "<c-w>s<cr>", desc("Split Window Horizontally"))

map("n", "<leader>wd", "<cmd>close<cr>", desc("Close Current Window"))
map("n", "<leader>wD", "<c-w><c-o><cr>", desc("Close Other Windows"))

map(
    "n",
    "<leader>ws",
    "<cmd>exe '1wincmd w | wincmd '.(winwidth(0) == &columns ? 'H' : 'K')<CR>",
    desc("Toggle Split Layout")
)

--- show documentation in a popup window ---------------------------------------
map("n", "<leader>k", "<cmd>normal! K<cr>", desc("Show Documentation"))

--- navigate terminal windows more easily --------------------------------------
map("t", "<Esc><Esc>", "<C-\\><C-n>", desc("Exit Terminal Mode"))
map("t", "<c-h>", "<C-\\><C-N><C-w>h", desc("Switch to Left Window"))
map("t", "<c-j>", "<C-\\><C-N><C-w>j", desc("Switch to Bottom Window"))
map("t", "<c-k>", "<C-\\><C-N><C-w>k", desc("Switch to Top Window"))
map("t", "<c-l>", "<C-\\><C-N><C-w>l", desc("Switch to Right Window"))

--- toggle wrap ----------------------------------------------------------------
local toggle_wrap = ToggleOption:new("<leader>oew", function(state)
    vim.wo.wrap = state
    vim.wo.linebreak = state
end, function()
    return vim.wo.wrap
end, "Wrap")

--- toggle numbers -------------------------------------------------------------
local toggle_numbers = ToggleOption:new("<leader>oen", function(state)
    vim.wo.number = state
end, function()
    return vim.wo.number
end, "Numbers")

--- toggle relative numbers ----------------------------------------------------
local toggle_relative = ToggleOption:new("<leader>oer", function(state)
    vim.wo.relativenumber = state
end, function()
    return vim.wo.relativenumber
end, "Relative Numbers")

--- move selected line / block of text in visual mode --------------------------
map("x", "<m-j>", ":m '>+1<cr>gv=gv", desc("Move Selected Down"))
map("x", "<m-k>", ":m '<-2<cr>gv=gv", desc("Move Selected Up"))

--- quickfix related stuff -----------------------------------------------------
vim.keymap.set("n", "<leader>q", function()
    local qf = vim.fn.getqflist({ winid = 0 })
    if qf.winid ~= 0 then
        vim.cmd("cclose")
    else
        vim.cmd("copen | wincmd J")
    end
end, { desc = "Toggle quickfix" })

--- location list related stuff ------------------------------------------------
vim.keymap.set("n", "<leader>Q", function()
    local loclist = vim.fn.getloclist(0, { winid = 0, size = 0 })
    if loclist.winid ~= 0 then
        vim.cmd("lclose")
    elseif loclist.size > 0 then
        vim.cmd("lopen")
    else
        vim.notify("No location list", vim.log.levels.WARN)
    end
end, { desc = "Toggle location list" })

map("n", "<m-j>", "<cmd>cnext<cr>", desc("Next Item in Quicklist"))
map("n", "<m-k>", "<cmd>cprev<cr>", desc("Prev Item in Quicklist"))

--- paste over currently selected text without yanking it ----------------------
-- disabled in favor of native behavior of Neovim
-- map("v", "p", '"_dp', desc("Paste Over Selected Text"))
-- map("v", "P", '"_dP', desc("Paste Over Selected Text"))

--- better movement in wrap mode -----------------------------------------------
map("n", "j", "gj")
map("n", "k", "gk")

--- navigate tabs --------------------------------------------------------------
map("n", "<right>", ":tabnext<cr>", desc("Next Tab"))
map("n", "<left>", ":tabprevious<cr>", desc("Prev Tab"))

--- command line up/down arrow alias -------------------------------------------
-- useful for searching history by first letters
map("c", "<C-k>", "<up>", desc("Command line up-arrow ailas"))
map("c", "<C-j>", "<down>", desc("Command line down-arrow ailas"))

--- alias to <esc> -------------------------------------------------------------
-- map("i", "jk", "<esc>", opts)
-- map("i", "kj", "<esc>", opts)
