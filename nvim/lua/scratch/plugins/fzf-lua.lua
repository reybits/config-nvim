vim.g.fzf_resume = false

local ToggleOption = require("scratch.core.toggleopt")

local toggle_fzfresume = ToggleOption:new("<leader>op", function(state)
    vim.g.fzf_resume = state
end, "Fzf Persistent Mode", vim.g.fzf_resume)

--- Checks if the given mode is the same as the last used mode.
--- @return function Returns isResumeEnabled function
local function createResume()
    local lastUsedMode = ""

    --- @param mode string The current mode.
    --- @return boolean True if the mode is the same as the last one, false otherwise.
    return function(mode)
        if vim.g.fzf_resume == false then
            return false
        end

        local isSame = (mode == lastUsedMode)
        lastUsedMode = mode
        return isSame
    end
end
local isResumeEnabled = createResume()

return {
    "ibhagwan/fzf-lua",
    event = "BufRead",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    cmd = {
        "FzfLua",
        "DashFiles",
        "DashGrep",
        "UiHandleSelect",
    },
    -- stylua: ignore
    keys = {
        {
            toggle_fzfresume:getMapping(),
            toggle_fzfresume:getToggleFunc(),
            desc = toggle_fzfresume:getCurrentDescription(),
        },
        { "<leader>,", function()
                require('fzf-lua').buffers({ resume = isResumeEnabled("buffers") })
            end, desc = "Buffers List" },
        { "<leader>bb", function()
                require('fzf-lua').buffers({ resume = isResumeEnabled("buffers") })
            end, desc = "Buffers List" },

        { "<leader>fr", function()
                require('fzf-lua').oldfiles({ resume = isResumeEnabled("oldfiles") })
            end, desc = "Recent Files" },

        { "<leader><space>", function()
                require('fzf-lua').files({ resume = isResumeEnabled("files") })
            end, desc = "Project Files" },
        { "<leader>fp", function()
                require('fzf-lua').files({ resume = isResumeEnabled("files") })
            end, desc = "Project Files" },

        { "<leader>ff", function ()
                require('fzf-lua').files({
                    cwd = vim.fn.expand('%:h'),
                    resume = isResumeEnabled("filescwd") })
            end, desc = "Current Dir Files" },

        { "<leader>fC", function ()
                require('fzf-lua').files({
                    cwd = vim.fn.stdpath('config'),
                    resume = isResumeEnabled("filescwd") })
            end, desc = "Neovim Config Files" },

        { "<leader>fP", function ()
                require('fzf-lua').files({
                    cwd = require('lazy.core.config').options.root,
                    resume = isResumeEnabled("filescwd") })
            end, desc = "Neovim Plugin Files" },

        { "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Fuzzy Search Buffer" },

        { "<leader>sg", "<cmd>FzfLua live_grep_native<cr>", desc = "Live Grep" },
        { "<leader>sG", function ()
                require('fzf-lua').live_grep_native({ cwd = vim.fn.expand('%:h') })
            end, desc = "Live Grep (cwd)" },

        { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep String" },
        { "<leader>sW", function ()
                require('fzf-lua').grep_cword({ cwd = vim.fn.expand('%:h') })
            end, desc = "Grep Word (cwd)" },

        -- Key binding for TODO comments has been moved to the "folke/todo-comments.nvim" plugin.
        -- { "<leader>st", "<cmd>TodoFzfLua<cr>", desc = "Find TODO/INFO/..." },

        { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "Search Help" },
        { "<leader>sm", "<cmd>FzfLua manpages<cr>", desc = "Search Man" },
        { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Search Keymaps" },

        -- Moved to the Trouble plugin.
        -- { "<leader>cs", function()
        --         require('fzf-lua').lsp_document_symbols({
        --             winopts = { preview = { layout = "horizontal" } } })
        --     end, desc = "Show Document Symbols" },
        -- { "<leader>ci", "<cmd>FzfLua lsp_incoming_calls<cr>",  desc = "Show Incoming Calls" },
        -- { "<leader>cr", "<cmd>FzfLua lsp_references<cr>", desc = "Show References" },
        -- { "<leader>cD", "<cmd>FzfLua diagnostics_document<cr>", desc = "Show Diagnostics" },
    },
    config = function()
        local fzflua = require("fzf-lua")
        local actions = fzflua.actions

        -- Support for dashboard-specific commands.
        vim.api.nvim_create_user_command("DashFiles", function(opts)
            opts = opts or {}
            local args = {}

            for key, value in string.gmatch(opts.args, "([^%s=]+)=([^{%s]+)") do
                args[key] = value
            end

            -- print("r: " .. vim.inspect(args))

            require("fzf-lua").files(args)
        end, { nargs = "*" })
        vim.api.nvim_create_user_command("DashGrep", function()
            require("fzf-lua").live_grep()
        end, {})

        fzflua.setup({
            -- profile
            "hide", -- or "telescope",

            winopts = {
                width = 0.96,
                height = 0.96,
                preview = {
                    layout = "vertical",
                    vertical = "up:70%",
                },
            },
            keymap = {
                builtin = {
                    false,
                    ["<F1>"] = "toggle-help",
                    ["<M-/>"] = "toggle-help",

                    ["<M-S-f>"] = "toggle-fullscreen",

                    ["<M-p>"] = "toggle-preview",
                    ["<M-w>"] = "toggle-preview-wrap",

                    ["<M-c>"] = "toggle-preview-cw",
                    ["<M-S-c>"] = "toggle-preview-ccw",

                    ["<C-d>"] = "preview-page-down",
                    ["<C-u>"] = "preview-page-up",
                },
                fzf = {
                    false,
                    ["alt-a"] = "toggle-all",
                    ["alt-g"] = "first",
                    ["alt-G"] = "last",
                },
            },
            files = {
                hidden = false,
            },
            buffers = {
                prompt = "❯ ",
            },
            keymaps = {
                prompt = "❯ ",
                winopts = { preview = { hidden = true } },
            },
            actions = {
                files = {
                    -- true, -- if set to true, enables default settings.

                    ["enter"] = actions.file_edit_or_qf,
                    ["ctrl-q"] = actions.file_sel_to_qf,
                    ["alt-f"] = actions.toggle_follow,
                    ["alt-h"] = actions.toggle_hidden,
                    ["alt-i"] = actions.toggle_ignore,
                    ["ctrl-s"] = actions.file_split,
                    ["ctrl-v"] = actions.file_vsplit,
                },
            },
            fzf_opts = {
                ["--layout"] = "default", -- not working in neovim v0.11
                ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
            },
            previewers = {
                builtin = {
                    extensions = {
                        -- neovim terminal only supports `viu` block output
                        ["png"] = { "viu", "-b" },
                        ["jpg"] = { "viu", "-b" },
                        ["gif"] = { "viu", "-b" },
                        ["jpeg"] = { "viu", "-b" },
                        -- ["jpg"] = { "ueberzug" },
                    },
                    -- When using 'ueberzug' we can also control the way images
                    -- fill the preview area with ueberzug's image scaler, set to:
                    --   false (no scaling), "crop", "distort", "fit_contain",
                    --   "contain", "forced_cover", "cover"
                    -- For more details see:
                    -- https://github.com/seebye/ueberzug
                    -- ueberzug_scaler = "cover",
                },
            },
        })

        local is_ui_select_registered = false
        local function register_ui_select()
            if is_ui_select_registered == false then
                is_ui_select_registered = true
                require("fzf-lua").register_ui_select(function(_, items)
                    -- Automatic sizing of height of vim.ui.select
                    local min_h, max_h = 0.15, 0.70
                    local h = (#items + 4) / vim.o.lines
                    if h < min_h then
                        h = min_h
                    elseif h > max_h then
                        h = max_h
                    end
                    return {
                        winopts = {
                            height = h,
                            width = 0.6,
                            row = 0.5,
                        },
                    }
                end)
            end
        end

        register_ui_select()

        -- Create command to register vim.ui.select handler
        vim.api.nvim_create_user_command("UiHandleSelect", function()
            register_ui_select()
        end, {})
    end,
}
