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
    enabled = false,
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },
    cmd = {
        "FzfLua",
        "DashFiles",
        "DashRecent",
        "DashGrep",
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

        { "<leader>sg", "<cmd>FzfLua grep_project<cr>", desc = "Live Grep" },
        { "<leader>sG", function ()
                require('fzf-lua').grep_project({ cwd = vim.fn.expand('%:h') })
            end, desc = "Live Grep (cwd)" },

        { "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep String" },
        { "<leader>sW", function ()
                require('fzf-lua').grep_cword({ cwd = vim.fn.expand('%:h') })
            end, desc = "Grep Word (cwd)" },

        { "<leader>st", "<cmd>TodoFzfLua<cr>", desc = "Find TODO/INFO/..." },

        { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "Search Help" },
        { "<leader>sm", "<cmd>FzfLua manpages<cr>", desc = "Search Man" },
        { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Search Keymaps" },

        { "<leader>cs", function()
                require('fzf-lua').lsp_document_symbols({
                    winopts = { preview = { layout = "horizontal" } } })
            end, desc = "Show Document Symbols" },
        { "<leader>ci", "<cmd>FzfLua lsp_incoming_calls<cr>",  desc = "Show Incoming Calls" },
        { "<leader>cr", "<cmd>FzfLua lsp_references<cr>", desc = "Show References" },
        { "<leader>cd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Show Diagnostics" },
    },
    config = function()
        local fzflua = require("fzf-lua")
        local actions = fzflua.actions

        fzflua.register_ui_select({
            winopts = {
                height = 0.5,
                width = 0.5,
                row = 0.5,
                col = 0.5,
            },
        })

        -- Dashboard commands support
        vim.api.nvim_create_user_command("DashFiles", function(opts)
            opts = opts or {}
            local args = {}

            for key, value in string.gmatch(opts.args, "([^%s=]+)=([^{%s]+)") do
                args[key] = value
            end

            -- print("r: " .. vim.inspect(args))

            require("fzf-lua").files(args)
        end, { nargs = "*" })
        vim.api.nvim_create_user_command("DashRecent", function()
            require("fzf-lua").oldfiles()
        end, {})
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
                ["--layout"] = "default",
            },
        })
    end,
}
