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

--- close some filetypes with <q> ----------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "notify",
        "qf",
        "query",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
        "git",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        -- stylua: ignore
        vim.keymap.set( "n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

--- show buffer name on switch -----------------------------------------------

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = augroup("show_buffer_name"),
    callback = function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname ~= "" then
            local relname = vim.fn.fnamemodify(bufname, ":.")
            print("Switched to: " .. relname)
        end
    end,
})

--- close diff buffer with <gq> ----------------------------------------------

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = augroup("close_with_gq"),
    pattern = { "*" },
    callback = function(event)
        if vim.bo[event.buf].buftype == "acwrite" then
            vim.api.nvim_buf_set_option(0, "modifiable", false)
            vim.keymap.set("n", "gq", "<cmd>close<cr>", { buffer = event.buf })
        end
    end,
})

--- highlight when yanking (copying) text --------------------------------------
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = augroup("highlight-yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

--- open Trouble quickfix on :copen --------------------------------------------
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

--- automatically open Trouble quickfix ----------------------------------------
-- vim.api.nvim_create_autocmd("QuickFixCmdPost", {
--     callback = function()
--         vim.cmd([[Trouble qflist open]])
--     end,
-- })
