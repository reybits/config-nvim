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

-- plugins and tools managers
map("n", "<leader>tl", "<cmd>Lazy<cr>", desc("Lazy Manager"))
map("n", "<leader>tm", "<cmd>Mason<cr>", desc("Mason Manager"))

-- hide highligting by <esc>
map("n", "<esc>", "<cmd>nohl<cr>", desc("Clear Highligted text"))
map("n", "<c-[>", "<cmd>nohl<cr>", desc("Clear Highligted text"))

-- window related stuff
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

local custom_make = function(cmd)
    if os.getenv("TMUX") then
        os.execute(
            "tmux split-window -v -l 30% '" .. cmd .. " || exec $SHELL' ; tmux select-pane -U"
        )
    else
        vim.cmd("12split | terminal " .. cmd)
        vim.cmd("normal G") -- scroll to the bottom
        vim.cmd("wincmd p") -- return focus to previous window
    end
end

-- build resources
map("n", "<leader>rr", function()
    custom_make("make resources")
end, desc("Do 'make resources'"))

-- build compile_commands.json
map("n", "<leader>rc", function()
    custom_make("make build_compile_commands")
end, desc("Do 'make build_compile_commands'"))

-- toggle wrap
local toggle_wrap = ToggleOption:new("<leader>oew", function(state)
    vim.wo.wrap = state
    vim.wo.linebreak = state
end, "Wrap")
toggle_wrap:setState(vim.wo.wrap, false)

-- toggle numbers
local toggle_numbers = ToggleOption:new("<leader>oen", function(state)
    vim.wo.number = state
end, "Numbers")
toggle_numbers:setState(vim.wo.number, false)

-- toggle relative numbers
local toggle_relative = ToggleOption:new("<leader>oer", function(state)
    vim.wo.relativenumber = state
end, "Relative Numbers")
toggle_relative:setState(vim.wo.relativenumber, false)

-- move selected line / block of text in visual mode
map("v", "<m-j>", ":m '>+1<cr>gv=gv", desc("Move Selected Down"))
map("v", "<m-k>", ":m '<-2<cr>gv=gv", desc("Move Selected Up"))

-- quickfix related stuff
-- moved to quicker.lua plugin
--[[ 
map("n", "<leader>q", function()
    local qf_exists = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if
            vim.api.nvim_win_get_config(win).relative == ""
            and vim.bo[vim.api.nvim_win_get_buf(win)].buftype == "quickfix"
        then
            qf_exists = true
            break
        end
    end
    if qf_exists then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, desc("Toggle Quick List"))
--]]
map("n", "<m-j>", "<cmd>cnext<cr>", desc("Next Item in Quicklist"))
map("n", "<m-k>", "<cmd>cprev<cr>", desc("Prev Item in Quicklist"))

-- paste over currently selected text without yanking it
map("v", "p", '"_dp', desc("Paste Over Selected Text"))
map("v", "P", '"_dP', desc("Paste Over Selected Text"))

--- better movement in wrap mode
map("n", "j", "gj")
map("n", "k", "gk")

-- navigate tabs
map("n", "<right>", ":tabnext<cr>", desc("Next Tab"))
map("n", "<left>", ":tabprevious<cr>", desc("Prev Tab"))

-- command line up/down arrow alias, useful for searching history by first letters
map("c", "<C-k>", "<up>", desc("Command line up-arrow ailas"))
map("c", "<C-j>", "<down>", desc("Command line down-arrow ailas"))

-- alias to <esc>
-- map("i", "jk", "<esc>", opts)
-- map("i", "kj", "<esc>", opts)
