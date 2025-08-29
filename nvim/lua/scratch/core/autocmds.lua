--- augroup helper function ----------------------------------------------------

local function augroup(name, opts)
    opts = opts or { clear = true }
    return vim.api.nvim_create_augroup("scratch_" .. name, opts)
end

--- enable cursor line for current buffer only ---------------------------------

local grp_cursorline = augroup("cursorline")

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
    group = grp_cursorline,
    pattern = { "*" },
    command = "setlocal cursorline",
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
    group = grp_cursorline,
    pattern = { "*" },
    command = "setlocal nocursorline",
})

--- restore cursor position ----------------------------------------------------

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    group = augroup("restore_cursor"),
    pattern = { "*" },
    command = 'silent! normal! g`"zv',
})

--- close with <q> by filetype -------------------------------------------------

local close_with_q = augroup("close_with_q")

vim.api.nvim_create_autocmd("FileType", {
    group = close_with_q,
    pattern = {
        "PlenaryTestPopup",
        "acwrite",
        "checkhealth",
        "git",
        "gitsigns-blame",
        "help",
        "lspinfo",
        "neotest-output",
        "neotest-output-panel",
        "neotest-summary",
        "notify",
        "qf",
        "query",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        if vim.api.nvim_buf_is_valid(event.buf) then
            vim.bo[event.buf].buflisted = false
            vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        end
    end,
})

--- close with <q> by buftype (not filetype) -----------------------------------

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = close_with_q,
    callback = function(event)
        -- Skip if filetype is in the list
        local skip_by_filetypes = {
            oil = true,
        }
        local ft = vim.bo[event.buf].filetype
        if skip_by_filetypes[ft] then
            return
        end

        -- Close if buftype is in the list
        local close_by_buftypes = {
            acwrite = true,
            quickfix = true,
        }
        local bt = vim.bo[event.buf].buftype
        if close_by_buftypes[bt] then
            vim.bo[event.buf].modifiable = false
            vim.keymap.set(
                "n",
                "q",
                "<cmd>close<cr>",
                { buffer = event.buf, silent = true, noremap = true }
            )
        end
    end,
})

--- trouble.nvim releated autocmds ---------------------------------------------

-- open Trouble quickfix on :copen
-- vim.api.nvim_create_autocmd("BufRead", {
--     callback = function(ev)
--         if vim.bo[ev.buf].buftype == "quickfix" then
--             vim.schedule(function()
--                 vim.cmd([[cclose]])
--                 vim.cmd([[Trouble qflist open]])
--             end)
--         end
--     end,
-- })

-- automatically open Trouble quickfix
-- vim.api.nvim_create_autocmd("QuickFixCmdPost", {
--     callback = function()
--         vim.cmd([[Trouble qflist open]])
--     end,
-- })

--- show buffer name on switch -------------------------------------------------

-- INFO: disabled due to mess notification and not useful enough
--[[
--- Checks if the given name is the same as the last used name.
--- @return function Returns lastBufNameFunction function
local function createBufNameFunction()
    local lastBufName = ""

    return function(event)
        local list = {
            "Neogit",
            "NvimTree",
            "floggraph",
            "fugitive",
            "git",
            "help",
            "neo-tree",
        }
        local filetype = vim.bo[event.buf].filetype
        for _, name in ipairs(list) do
            if filetype == name then
                lastBufName = name
                return
            end
        end

        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname ~= "" and lastBufName ~= bufname then
            lastBufName = bufname
            local relname = vim.fn.fnamemodify(bufname, ":.")
            ---@diagnostic disable-next-line: missing-fields
            vim.notify(relname, nil, { key = "file_switch", annote = "󰈔" })
        end
    end
end
local lastBufNameFunction = createBufNameFunction()

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = augroup("show_buffer_name"),
    callback = lastBufNameFunction,
})
--]]

--- clear colorcolumn for some filetypes ---------------------------------------

vim.api.nvim_create_autocmd("FileType", {
    group = augroup("clean_window_opts"),
    pattern = {
        "NeogitLogView",
        "NeogitStatus",
        "checkhealth",
        "git",
        "help",
        "lspinfo",
        "oil",
        "qf",
        "query",
    },
    callback = function()
        vim.opt_local.cc = ""
        vim.opt_local.signcolumn = "no"
    end,
})

--- highlight when yanking (copying) text --------------------------------------

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = augroup("highlight-yank"),
    callback = function()
        vim.hl.on_yank()
        -- TODO: vim.highlight deprecated, remove it.
        -- vim.highlight.on_yank()
    end,
})
