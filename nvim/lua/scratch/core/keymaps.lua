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

--- show buffer path after switching buffer ------------------------------------
map("n", "<c-^>", "<c-^>:normal! <c-g><CR>", desc("Show Buffer Path"))

--- show documentation in a popup window ---------------------------------------
map("n", "<leader>k", "<cmd>normal! K<cr>", desc("Show Documentation"))

--- navigate terminal windows more easily --------------------------------------
map("t", "<Esc>", "<C-\\><C-n>", desc("Exit Terminal Mode"))
map("t", "<c-h>", "<C-\\><C-N><C-w>h", desc("Switch to Left Window"))
map("t", "<c-j>", "<C-\\><C-N><C-w>j", desc("Switch to Bottom Window"))
map("t", "<c-k>", "<C-\\><C-N><C-w>k", desc("Switch to Top Window"))
map("t", "<c-l>", "<C-\\><C-N><C-w>l", desc("Switch to Right Window"))

--- Disabled in favor of 'reybits/anvil.nvim' plugin ---------------------------
--[[
local custom_make = function(cmd, on_exit, opts)
    -- vim.notify("Exec command: '" .. cmd .. "'.", vim.log.levels.INFO)
    opts = opts or {}

    local tmpfile = vim.fn.tempname() .. ".ret"
    os.remove(tmpfile)

    local outfile = vim.fn.tempname() .. ".log"
    if opts.log_to_qf then
        os.remove(outfile)
    end

    if os.getenv("TMUX") then
        local tmux_cmd
        if opts.log_to_qf then
            tmux_cmd = string.format(
                "tmux split-window -v -l 30%% '(%s 2>&1 | tee %s); echo $? > %s || exec $SHELL'; tmux select-pane -U",
                cmd,
                outfile,
                tmpfile
            )
        else
            tmux_cmd = string.format(
                "tmux split-window -v -l 30%% '%s; echo $? > %s || exec $SHELL'; tmux select-pane -U",
                cmd,
                tmpfile
            )
        end

        vim.fn.jobstart(tmux_cmd, { shell = true })
    else
        vim.api.nvim_create_autocmd("TermClose", {
            group = vim.api.nvim_create_augroup("scratch_close_term_buffer", { clear = true }),
            callback = function()
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    if vim.bo[buf].buftype == "terminal" then
                        vim.api.nvim_win_close(win, true)
                        vim.api.nvim_buf_delete(buf, { force = true })
                        return
                    end
                end
            end,
        })

        local prev_win = vim.api.nvim_get_current_win()

        -- make split for terminal window and run terminal command
        local term_cmd
        if opts.log_to_qf then
            term_cmd = string.format("terminal %s; echo $? > %s", cmd, tmpfile)
        else
            term_cmd =
                string.format("terminal (%s 2>&1 | tee %s); echo $? > %s", cmd, outfile, tmpfile)
        end
        vim.cmd("split | " .. term_cmd)

        -- scroll to the bottom
        vim.cmd("normal G")

        -- move terminal window to the bottom
        vim.cmd("wincmd J")

        -- reseize terminal window to fixed height
        local height = math.floor(0.3 * vim.o.lines)
        vim.cmd("resize " .. height)

        -- return focus to previous window
        if vim.api.nvim_win_is_valid(prev_win) then
            vim.api.nvim_set_current_win(prev_win)
        end
    end

    -- Wait for the command to finish
    local timer = vim.uv.new_timer()
    if timer ~= nil then
        timer:start(
            500,
            500,
            vim.schedule_wrap(function()
                local f = io.open(tmpfile, "r")
                if f then
                    local code = tonumber(f:read("*a"))
                    f:close()

                    timer:stop()
                    timer:close()

                    os.remove(tmpfile)

                    if opts.log_to_qf then
                        local o = io.open(outfile, "r")
                        if o then
                            local lines = {}
                            for line in o:lines() do
                                table.insert(lines, line)
                            end
                            o:close()
                            os.remove(outfile)

                            vim.fn.setqflist({}, "r", { title = "Make Output", lines = lines })
                        end
                    end

                    if on_exit then
                        on_exit(code)
                    else
                        vim.notify(
                            "Command '" .. cmd .. "' finished: " .. code .. ".",
                            code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
                        )
                    end
                end
            end)
        )
    end
end

map("n", "<leader>ra", function()
    custom_make("make android", function(code)
        if code == 0 then
            vim.notify("Android Release finished.", vim.log.levels.INFO)
        else
            vim.notify("Android Release failed.", vim.log.levels.ERROR)
            vim.cmd("copen | wincmd J")
        end
    end, { log_to_qf = true })
end, desc("Do 'make android'"))

map("n", "<leader>rA", function()
    custom_make("make .android", function(code)
        if code == 0 then
            vim.notify("Android Debug finished.", vim.log.levels.INFO)
        else
            vim.notify("Android Debug failed.", vim.log.levels.ERROR)
            vim.cmd("copen | wincmd J")
        end
    end, { log_to_qf = true })
end, desc("Do 'make .android'"))

map("n", "<leader>rb", function()
    custom_make("make release", function(code)
        if code == 0 then
            vim.notify("Build Release finished.", vim.log.levels.INFO)
        else
            vim.notify("Build Release failed.", vim.log.levels.ERROR)
            vim.cmd("copen | wincmd J")
        end
    end, { log_to_qf = true })
end, desc("Do 'make release'"))

map("n", "<leader>rB", function()
    custom_make("make .debug", function(code)
        if code == 0 then
            vim.notify("Build Debug finished.", vim.log.levels.INFO)
        else
            vim.notify("Build Debug failed.", vim.log.levels.ERROR)
            vim.cmd("copen | wincmd J")
        end
    end, { log_to_qf = true })
end, desc("Do 'make .debug'"))

map("n", "<leader>rw", function()
    custom_make("make web", function(code)
        if code == 0 then
            vim.notify("Web Release finished.", vim.log.levels.INFO)
        else
            vim.notify("Web Release failed.", vim.log.levels.ERROR)
            vim.cmd("copen | wincmd J")
        end
    end, { log_to_qf = true })
end, desc("Do 'make web'"))

map("n", "<leader>rW", function()
    custom_make("make .web", function(code)
        if code == 0 then
            vim.notify("Web Debug finished.", vim.log.levels.INFO)
        else
            vim.notify("Web Debug failed.", vim.log.levels.ERROR)
            vim.cmd("copen | wincmd J")
        end
    end, { log_to_qf = true })
end, desc("Do 'make .web'"))

--- build resources
map("n", "<leader>rr", function()
    custom_make("make resources", function(code)
        if code == 0 then
            vim.notify("Resources builded.", vim.log.levels.INFO)
        else
            vim.notify("Resource build failed.", vim.log.levels.ERROR)
        end
    end)
end, desc("Do 'make resources'"))

--- build compile_commands.json
map("n", "<leader>rc", function()
    custom_make("make build_compile_commands", function(code)
        if code == 0 then
            vim.notify("Rebuild compile_commands.json successfully.", vim.log.levels.INFO)
            vim.cmd("LspRestart")
        else
            vim.notify("Failed to rebuild compile_commands.json.", vim.log.levels.ERROR)
        end
    end)
end, desc("Do 'make build_compile_commands'"))
--]]

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
