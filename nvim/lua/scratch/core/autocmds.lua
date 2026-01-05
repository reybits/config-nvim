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
    command = 'silent! normal! g`"zvzz',
})

--- equalize window sizes on VimResized ----------------------------------------

vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("vim_resized"),
    command = "wincmd =",
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

        local bt = vim.bo[event.buf].buftype

        -- Close if buftype is in the list
        local close_by_buftypes = {
            help = true, -- For help in markdown files when not detected by FileType.
            acwrite = true,
            quickfix = true,
        }

        if close_by_buftypes[bt] then
            vim.bo[event.buf].modifiable = false
            vim.keymap.set(
                "n",
                "q",
                "<cmd>close<cr>",
                { buffer = event.buf, silent = true, noremap = true }
            )
        end

        -- Set options by buftype
        local opts_by_buftypes = {
            help = function()
                vim.opt_local.cc = ""
                vim.opt_local.signcolumn = "no"
                vim.opt_local.wrap = true
            end,
        }

        if opts_by_buftypes[bt] then
            opts_by_buftypes[bt]()
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

--- show buffer path after switching buffer ------------------------------------

local last_buf_path = nil
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufNew" }, {
    group = augroup("show_buffer_path"),
    callback = function()
        vim.defer_fn(function()
            local buf = 0

            if not vim.api.nvim_buf_is_valid(buf) or not vim.bo[buf].buflisted then
                last_buf_path = nil
                vim.api.nvim_echo({ { "", "Normal" } }, false, {})
                return
            end

            local bufname = vim.api.nvim_buf_get_name(buf)
            if last_buf_path ~= bufname then
                last_buf_path = bufname
                vim.api.nvim_echo({ { bufname, "Normal" } }, false, {})
            end
        end, 50)
    end,
})

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
