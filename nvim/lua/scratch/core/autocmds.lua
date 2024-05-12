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

--- highlight when yanking (copying) text --------------------------------------
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = augroup("highlight-yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})
