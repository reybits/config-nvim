-- Chat window key bindings:
--   Press 'q'      to close the chat window.
--   Press <C-c>    to clear the chat history and close the window.

return {
    "olimorris/codecompanion.nvim",
    version = "^18.0.0",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",

        -- Optional dependency for spinner UI
        "franco-ruggeri/codecompanion-spinner.nvim",

        -- Optional dependency for chat history
        "ravitemer/codecompanion-history.nvim",
    },
    cmd = {
        "CodeCompanion",
        "CodeCompanionActions",
        "CodeCompanionChat",
        "CodeCompanionCmd",

        -- "ravitemer/codecompanion-history.nvim",
        "CodeCompanionHistory",
        "CodeCompanionSummaries",
    },
    keys = {
        {
            "<leader>aa",
            "<cmd>CodeCompanionChat Toggle<cr>",
            desc = "Toggle Chat",
        },
        {
            "<leader>aa",
            "<cmd>CodeCompanionChat Add<cr>",
            desc = "Add Selection to Chat",
            mode = "x",
        },
        {
            "<leader>ah",
            "<cmd>CodeCompanionHistory<cr>",
            desc = "Chat History",
        },
        {
            "<leader>ap",
            "<cmd>CodeCompanionActions<cr>",
            desc = "Select Action",
        },
        {
            "<leader>aq",
            function()
                vim.ui.input({ prompt = " Quick Chat: " }, function(input)
                    if input and input ~= "" then
                        require("codecompanion").chat({
                            messages = {
                                { role = "user", content = input },
                            },
                        })
                    end
                end)
            end,
            desc = "Quick Chat",
            mode = { "n", "x" },
        },
        {
            "<leader>ac",
            function()
                vim.fn.system("git diff --no-ext-diff --cached --quiet")
                if vim.v.shell_error == 0 then
                    vim.notify("No staged changes", vim.log.levels.WARN)
                    return
                end
                vim.cmd("CodeCompanion /better_commit")
            end,
            desc = "Commit Message",
        },
        {
            "<leader>ar",
            "<cmd>CodeCompanion /better_review<cr>",
            desc = "Review",
            mode = "x",
        },
        {
            "<leader>ae",
            "<cmd>CodeCompanion /explain<cr>",
            desc = "Explain",
            mode = "x",
        },
        {
            "<leader>ad",
            "<cmd>CodeCompanion /better_docs<cr>",
            desc = "Docs",
            mode = "x",
        },
        {
            "<leader>af",
            "<cmd>CodeCompanion /fix<cr>",
            desc = "Fix",
            mode = "x",
        },
        {
            "<leader>ao",
            "<cmd>CodeCompanion /better_optimize<cr>",
            desc = "Optimize",
            mode = "x",
        },
        {
            "<leader>al",
            "<cmd>CodeCompanion /lsp<cr>",
            desc = "LSP",
            mode = { "n", "x" },
        },
    },
    init = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>a", group = "AI", mode = { "n", "x" } },
        })
    end,
    opts = {
        -- NOTE: The log_level is in `opts.opts`
        opts = {
            log_level = "DEBUG",
        },
        display = {
            action_palette = {
                provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
            },
            chat = {
                show_header_separator = true, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
                separator = "-·", -- The separator between the different messages in the chat buffer
                fold_context = true,
                show_token_count = true, -- Show the token count for each response?
                show_tools_processing = true, -- Show the loading message when tools are being executed?

                icons = {
                    buffer_sync_all = "󰪴 ",
                    buffer_sync_diff = " ",
                    chat_context = " ",
                    chat_fold = " ",
                    tool_pending = "  ",
                    tool_in_progress = "  ",
                    tool_failure = "  ",
                    tool_success = "  ",
                },
                window = {
                    opts = {
                        -- Additional buffer options.
                        relativenumber = false,
                        number = false,
                        signcolumn = "no",
                    },
                },
            },
        },
        extensions = {
            spinner = {
                log_level = "error",
            },
            history = {
                opts = {
                    dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_chats.json",
                },
            },
        },
        prompt_library = {
            markdown = {
                dirs = {
                    vim.fn.getcwd() .. "/.prompts", -- Can be relative
                    vim.fn.stdpath("config") .. "/prompts", -- Or absolute paths
                },
            },
        },
    },
    -- config = function(_, opts)
    --     vim.api.nvim_create_autocmd("FileType", {
    --         pattern = "codecompanion",
    --         callback = function(args)
    --             -- Defer keymap setting to before buffer is fully ready.
    --             vim.schedule(function()
    --                 if vim.api.nvim_buf_is_valid(args.buf) then
    --                     -- Enable Markview for the buffer
    --                     vim.cmd("Markview enable")
    --                 end
    --             end)
    --         end,
    --     })
    --
    --     require("codecompanion").setup(opts)
    -- end,
}
