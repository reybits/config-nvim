return {
    "echasnovski/mini.sessions",
    version = false,
    dependencies = {
        "stevearc/dressing.nvim",
    },
    cmd = {
        "SessionsList",
        "SessionRead",
        "SessionReadLast",
        "SessionWrite",
    },
    keys = {
        {
            "<leader>os",
            function()
                vim.g.minisessions_disable = not vim.g.minisessions_disable
                vim.notify(
                    "Session save " .. (vim.g.minisessions_disable and "disabled" or "enabled")
                )
            end,
            desc = "Toggle Store Session",
        },
    },
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
        vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

        vim.api.nvim_create_user_command("SessionsList", function()
            session.select()
        end, {
            desc = "Sessions List",
        })

        vim.api.nvim_create_user_command("SessionRead", function(args)
            session.read(args.args)
        end, {
            desc = "Read Session",
        })

        vim.api.nvim_create_user_command("SessionReadLast", function()
            local last_name = session.get_latest()
            session.read(last_name)
        end, {
            desc = "Read Last Session",
        })

        vim.api.nvim_create_user_command("SessionWrite", function()
            session.write()
        end, {
            desc = "Write Session",
        })
    end,
}
