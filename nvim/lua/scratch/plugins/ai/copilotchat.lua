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
    opts = function()
        local user = vim.env.USER or "User"
        user = user:sub(1, 1):upper() .. user:sub(2)
        return {
            auto_insert_mode = true,
            question_header = "  " .. user .. " ",
            answer_header = "  Copilot ",
            window = {
                width = 0.4,
            },
        }
    end,
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
            "<leader>af",
            "<cmd>CopilotChatFix<cr>",
            desc = "Copilot FixIt",
            mode = { "n", "v" },
        },
        {
            "<leader>ao",
            "<cmd>CopilotChatOptimize<cr>",
            desc = "Copilot OptimizeIt",
            mode = { "n", "v" },
        },
    },
    config = function(_, opts)
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "copilot-chat",
            callback = function()
                vim.opt_local.relativenumber = false
                vim.opt_local.number = false
            end,
        })

        local chat = require("CopilotChat")
        chat.setup(opts)
    end,
}
