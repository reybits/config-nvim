return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        -- { "github/copilot.vim" },
        -- { "zbirenbaum/copilot.lua" },
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
            "<leader>aa",
            function()
                return require("CopilotChat").toggle()
            end,
            desc = "Toggle Copilot Chat",
            mode = { "n", "v" },
        },
        {
            "<leader>ap",
            function()
                require("CopilotChat").select_prompt()
            end,
            desc = "Select Copilot Prompt",
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
                    if input and input ~= "" then
                        require("CopilotChat").ask(input)
                    end
                end)
            end,
            desc = "Quick Copilot Chat",
            mode = { "n", "v" },
        },
        {
            "<leader>ac",
            function()
                local result = vim.system({ "git", "diff", "--staged", "--quiet" }):wait()
                if result.code == 0 then
                    vim.notify("No staged changes", vim.log.levels.WARN)
                    return
                end
                local chat = require("CopilotChat")
                chat.reset()
                chat.ask("/Commit")
            end,
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
            model = "gpt-4.1", -- AI model to use
            temperature = 0.1, -- Lower = focused, higher = creative

            prompts = {
                BetterNamings = "Please provide better names for the following variables and functions.",
                Concise = "Please rewrite the following text to make it more concise.",
                FixCode = "Please fix the following code to make it work as intended.",
                FixError = "Please explain the error in the following text and provide a solution.",
                Refactor = "Please refactor the following code to improve its clarity and readability.",
                Review = "Please review the following code and provide suggestions for improvement.",
                Summarize = "Please summarize the following text.",
                Wording = "Please improve the grammar and wording of the following text.",
                Commit = "Analyze the git diff below and generate a Conventional Commit message.\n- Use the appropriate type (feat, fix, chore, docs, style, refactor, perf, test, build, ci, etc.).\n- Include a scope if relevant: <type>(<scope>): <description>.\n- Write a short, imperative description, max 72 characters per line.\n- If needed, add a body with details or context, wrapped at 72 chars.\n- Add footers if relevant (e.g., breaking changes, issues closed).\n- Output only the commit message inside a markdown code block.\n\n#gitdiff:staged",
            },

            -- auto_insert_mode = true,
            chat_autocomplete = false, -- handled in BufEnter autocmd below
            separator = "·", -- "━━",
            -- auto_fold = true, -- Automatically folds non-assistant messages

            mappings = {
                complete = false, -- handled via Tab in BufEnter autocmd below
                show_help = {
                    normal = "g?",
                },
                reset = {
                    normal = "<C-r>",
                    insert = "<C-r>",
                    callback = function()
                        require("CopilotChat").reset()
                    end,
                },
            },

            window = {
                layout = "vertical",
                width = 0.5,
            },

            headers = {
                -- Icons: 👤 🤖
                user = "   " .. user .. " ",
                assistant = "   Copilot ",
                tool = " 🔧 Tool ",
            },
        }
    end,
    init = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>a", group = "AI" },
        })
    end,
    config = function(_, opts)
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "copilot-*",
            callback = function()
                vim.opt_local.relativenumber = false
                vim.opt_local.number = false
            end,
        })

        require("CopilotChat").setup(opts)
    end,
}
