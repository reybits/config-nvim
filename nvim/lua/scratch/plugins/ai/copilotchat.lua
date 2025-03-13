return {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false,
    dependencies = {
        { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
        { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- only on MacOS or Linux
    cmd = {
        "CopilotChat",
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
        { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
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
                local input = vim.fn.input("Quick Chat: ")
                if input ~= "" then
                    require("CopilotChat").ask(input)
                end
            end,
            desc = "Quick Copilot Chat",
            mode = { "n", "v" },
        },
    },
    config = function(_, opts)
        local chat = require("CopilotChat")

        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "copilot-chat",
            callback = function()
                vim.opt_local.relativenumber = false
                vim.opt_local.number = false
            end,
        })

        chat.setup(opts)
    end,
}
