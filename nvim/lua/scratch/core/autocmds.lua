--- augroup helper function ----------------------------------------------------

local function augroup(name, opts)
    opts = opts or { clear = true }
    return vim.api.nvim_create_augroup("scratch_" .. name, opts)
end

--- vifm in the terminal -------------------------------------------------------

local vifm_term = nil

local function toggle_vifm_terminal()
    if vifm_term and vim.api.nvim_buf_is_valid(vifm_term) then
        -- Switch all windows showing this buffer to an alternate buffer
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == vifm_term then
                local alt = vim.fn.bufnr("#")
                if alt > 0 and vim.api.nvim_buf_is_valid(alt) and alt ~= vifm_term then
                    vim.api.nvim_win_set_buf(win, alt)
                else
                    vim.api.nvim_win_set_buf(win, vim.api.nvim_create_buf(false, true))
                end
            end
        end
        vim.api.nvim_buf_delete(vifm_term, { force = true })
        vifm_term = nil
    else
        vim.cmd("enew")
        vim.cmd("terminal vifm")
        -- Capture the actual terminal buffer after :terminal runs
        local buf = vim.api.nvim_get_current_buf()
        vim.cmd("startinsert")
        vifm_term = buf

        vim.api.nvim_create_autocmd("TermClose", {
            buffer = buf,
            once = true,
            callback = function()
                vifm_term = nil
                vim.schedule(function()
                    if vim.api.nvim_buf_is_valid(buf) then
                        vim.api.nvim_buf_delete(buf, { force = true })
                    end
                end)
            end,
        })
    end
end

vim.keymap.set("n", "<leader>e", toggle_vifm_terminal, { desc = "Toggle Vifm" })

--- startup handler ------------------------------------------------------------
-- Currently experimental and disabled.
-- I really consider using it instad of mini.sessions and dashboard-nvim plugins.

--[[
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    group = augroup("startup_handler"),
    once = true,
    pattern = { "*" },
    callback = function()
        -- Always register UiHandleSelect on startup
        vim.cmd("UiHandleSelect")

        -- If there are files passed as arguments, do nothing.
        if vim.fn.argc() > 0 then
            return
        end

        -- Check for Session.vim in the current working directory.
        local session = vim.fn.getcwd() .. "/Session.vim"
        if vim.fn.filereadable(session) ~= 1 then
            return
        end

        vim.schedule(function()
            vim.ui.select(
                { "Load session", "Skip" },
                { prompt = "Session found. What do you want to do?" },
                function(choice)
                    if choice == "Load session" then
                        vim.cmd("source " .. vim.fn.fnameescape(session))
                    end
                end
            )
        end)
    end,
})
--]]

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
        "codecompanion",
        "git",
        "gitsigns-blame",
        "help",
        "lspinfo",
        "marker-groups",
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
        -- Defer keymap setting to before buffer is fully ready.
        vim.schedule(function()
            if vim.api.nvim_buf_is_valid(event.buf) then
                vim.bo[event.buf].buflisted = false
                vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
            end
        end)
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
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter", "BufEnter" }, {
    group = augroup("show_buffer_path"),
    callback = function()
        vim.defer_fn(function()
            if vim.api.nvim_get_mode().mode ~= "n" then
                return
            end

            local buf = vim.api.nvim_get_current_buf()

            if not vim.api.nvim_buf_is_valid(buf) or not vim.bo[buf].buflisted then
                last_buf_path = nil
                vim.api.nvim_echo({ { "", "Normal" } }, false, {})
                return
            end

            local bufname = vim.api.nvim_buf_get_name(buf)
            if last_buf_path ~= bufname then
                last_buf_path = bufname
                local relpath = vim.fn.fnamemodify(bufname, ":.")
                local width = vim.o.columns - 2
                if #relpath > width then
                    local keep = math.floor((width - 1) / 2)
                    local left = relpath:sub(1, keep)
                    local right = relpath:sub(-keep)
                    relpath = left .. "…" .. right
                end
                vim.api.nvim_echo({ { relpath, "Normal" } }, false, {})
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
    end,
})
