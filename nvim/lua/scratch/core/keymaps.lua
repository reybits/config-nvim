--------------------------------------------------------------------------------

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local desc = function(desc)
    local merged = opts
    merged.desc = desc
    return merged
end

--------------------------------------------------------------------------------

-- plugins and tools managers
map("n", "<leader>tl", "<cmd>Lazy<cr>", desc("Lazy Manager"))
map("n", "<leader>tm", "<cmd>Mason<cr>", desc("Mason Manager"))

-- hide highligting by <esc>
map("n", "<esc>", "<cmd>nohl<cr>", desc("Clear Highligted text"))

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

-- build resources
vim.api.nvim_create_user_command("MakeResources", function()
    local exec_command = "make resources"

    if os.getenv("TMUX") then
        os.execute(
            "tmux split-window -v -l 30% '"
                .. exec_command
                .. " || exec $SHELL' ; tmux select-pane -U"
        )
    else
        vim.cmd("12split | terminal " .. exec_command)
        vim.cmd("normal G") -- scroll to the bottom
        vim.cmd("wincmd p") -- return focus to previous window
    end
end, {})

map("n", "<leader>rr", "<cmd>MakeResources<cr>", desc("Run: make resources"))

-- toggle wrap
map("n", "<leader>ow", function()
    local is_wrap = vim.api.nvim_win_get_option(0, "wrap")

    vim.api.nvim_win_set_option(0, "wrap", not is_wrap)
    vim.api.nvim_win_set_option(0, "linebreak", not is_wrap)
end, desc("Toggle Wrap"))

-- toggle numbers
map("n", "<leader>on", function()
    local is_number = vim.api.nvim_win_get_option(0, "number")

    vim.api.nvim_win_set_option(0, "number", not is_number)
end, desc("Toggle Numbers"))

-- toggle relative numbers
map("n", "<leader>or", function()
    local is_relative = vim.api.nvim_win_get_option(0, "relativenumber")

    vim.api.nvim_win_set_option(0, "relativenumber", not is_relative)
end, desc("Toggle Relative Numbers"))

-- move selected line / block of text in visual mode
map("v", "J", ":m '>+1<cr>gv=gv", desc("Move Selected Down"))
map("v", "K", ":m '<-2<cr>gv=gv", desc("Move Selected Up"))

-- quickfix related stuff
-- moved to quickfix.lua plugin
--[[ 
map("n", "<leader>q", function()
    local qf_exists = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if
            vim.api.nvim_win_get_config(win).relative == ""
            and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "buftype")
                == "quickfix"
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

map("n", "<up>", "<cmd>echo 'Use k to move!'<cr>", desc("Arrow Key Disabled"))
map("n", "<down>", "<cmd>echo 'Use j to move!'<cr>", desc("Arrow Key Disabled"))

-- alias to <esc>
-- map("i", "jk", "<esc>", opts)
-- map("i", "kj", "<esc>", opts)
