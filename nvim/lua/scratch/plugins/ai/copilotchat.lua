return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- only on MacOS or Linux
    cmd = {
        "CopilotChat",
        "CopilotChatAgents",
        "CopilotChatClose",
        "CopilotChatCommit",
        "CopilotChatDocs",
        "CopilotChatExplain",
        "CopilotChatFix",
        "CopilotChatLoad",
        "CopilotChatModels",
        "CopilotChatOpen",
        "CopilotChatOptimize",
        "CopilotChatPrompts",
        "CopilotChatReset",
        "CopilotChatReview",
        "CopilotChatSave",
        "CopilotChatStop",
        "CopilotChatTests",
        "CopilotChatToggle",
    },
    keys = {
        {
            "<c-s>",
            "<cr>",
            ft = "copilot-chat",
            desc = "Submit Prompt",
            mode = { "n", "v" },
            remap = true,
        },
        {
            "<leader>aa",
            function()
                return require("CopilotChat").toggle()
            end,
            desc = "Toggle Copilot Chat",
            mode = { "n", "v" },
        },
        {
            "<leader>ax",
            function()
                return require("CopilotChat").reset()
            end,
            desc = "Clear Copilot Chat",
            mode = { "n", "v" },
        },
        {
            "<leader>aq",
            function()
                vim.ui.input({ prompt = " Quick Chat: " }, function(input)
                    if input ~= "" then
                        require("CopilotChat").ask(input)
                    end
                end)
            end,
            desc = "Quick Copilot Chat",
            mode = { "n", "v" },
        },
        {
            "<leader>ac",
            "<cmd>CopilotChatCommit<cr>",
            desc = "Copilot Commit Message",
            mode = { "n", "v" },
        },
        {
            "<leader>ar",
            "<cmd>CopilotChatReview<cr>",
            desc = "Copilot Review",
            mode = { "n", "v" },
        },
        {
            "<leader>ae",
            "<cmd>CopilotChatExplain<cr>",
            desc = "Copilot Explain",
            mode = { "n", "v" },
        },
        {
            "<leader>ad",
            "<cmd>CopilotChatDocs<cr>",
            desc = "Copilot Docs",
            mode = { "n", "v" },
        },
        {
            "<leader>af",
            "<cmd>CopilotChatFix<cr>",
            desc = "Copilot Fix",
            mode = { "n", "v" },
        },
        {
            "<leader>ao",
            "<cmd>CopilotChatOptimize<cr>",
            desc = "Copilot Optimize",
            mode = { "n", "v" },
        },
    },
    opts = function()
        local user = vim.env.USER or "User"
        user = user:sub(1, 1):upper() .. user:sub(2)
        return {
            -- auto_insert_mode = true,
            question_header = "  " .. user .. " ",
            answer_header = "  Copilot ",
            window = {
                layout = "float", -- 'vertical', 'horizontal', 'float', 'replace'
                width = 0.6,
                height = 0.8,
                border = "rounded", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
                title = " Copilot Chat ", -- title of chat window
            },
        }
    end,
    config = function(_, opts)
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "copilot-chat",
            callback = function()
                vim.opt_local.relativenumber = false
                vim.opt_local.number = false
            end,
        })

        -- Close a window on WinLeave event
        vim.api.nvim_create_autocmd("WinLeave", {
            pattern = "copilot-chat",
            callback = function()
                local win = vim.api.nvim_get_current_win()
                if vim.api.nvim_win_get_config(win).relative ~= "" then
                    vim.api.nvim_win_close(win, true)
                end
            end,
        })

        local chat = require("CopilotChat")
        chat.setup(opts)
    end,
}
