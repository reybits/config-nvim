return {
    {
        "echasnovski/mini.starter",
        version = false,
        event = "VimEnter",
        dependencies = {
            "echasnovski/mini.sessions",
            version = false,
        },
        config = function()
            local starter = require("mini.starter")
            starter.setup({
                evaluate_single = true,
                -- header = "Hello",
                silent = true,
                items = {
                    -- Use this if you set up 'mini.sessions'
                    starter.sections.sessions(3, true),

                    starter.sections.recent_files(5, true),
                    starter.sections.recent_files(5, false),
                },
                content_hooks = {
                    starter.gen_hook.adding_bullet(),
                    -- starter.gen_hook.indexing("all", { "Builtin actions" }),
                    -- starter.gen_hook.padding(3, 2),
                    starter.gen_hook.aligning("center", "center"),
                },
            })
        end,
    },

    {
        "echasnovski/mini.sessions",
        version = false,
        config = function()
            local session = require("mini.sessions")
            session.setup({
                autoread = false,
                autowrite = true,
                -- file = "Session.vim",
                directory = vim.fn.stdpath("state") .. "/sessions/",
            })

            vim.g.minisessions_disable = false
            -- stylua: ignore
            vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

            vim.keymap.set("n", "<leader>os", function()
                vim.g.minisessions_disable = not vim.g.minisessions_disable

                -- stylua: ignore
                print("Session save " .. (vim.g.minisessions_disable and "disabled" or "enabled"))
            end, { desc = "Toggle Store Session" })
        end,
    },
}
