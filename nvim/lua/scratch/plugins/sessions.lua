return {
    --[[
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

                    -- recent filed (local directory)
                    starter.sections.recent_files(10, true),

                    -- recent filed (global)
                    starter.sections.recent_files(30, false),
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
    --]]

    {
        "echasnovski/mini.sessions",
        version = false,
        cmd = {
            "SessionsList",
            "SessionRead",
            "SessionReadLast",
            "SessionWrite",
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
            vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

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

            vim.keymap.set("n", "<leader>os", function()
                vim.g.minisessions_disable = not vim.g.minisessions_disable

                -- stylua: ignore
                print("Session save " .. (vim.g.minisessions_disable and "disabled" or "enabled"))
            end, { desc = "Toggle Store Session" })
        end,
    },

    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            vim.opt.cursorline = true -- enable cursor line

            require("dashboard").setup({
                theme = "hyper",
                config = {
                    week_header = {
                        enable = true,
                    },
                    disable_move = false,
                    project = {
                        enable = false,
                        limit = 5,
                        icon = " ",
                        label = "Browse Files in Directory",
                        action = "Telescope find_files preview={hide_on_startup=true} cwd=",
                    },
                    mru = {
                        limit = 25,
                        icon = " ",
                        label = "Recent Files List",
                        cwd_only = false,
                    },
                    shortcut = {
                        {
                            icon = " ", -- "󱉯  "
                            desc = "Sessions",
                            group = "Number", --"@property",
                            action = "SessionsList",
                            key = "s",
                        },
                        {
                            icon = "󱉯 ", -- "  "
                            desc = "Last Session",
                            group = "Number", --"@property",
                            action = "SessionReadLast",
                            key = "r",
                        },
                        {
                            icon = "󰉺 ", --   ",
                            desc = "Files",
                            group = "Label",
                            action = "Telescope find_files preview={hide_on_startup=true}",
                            key = "f",
                        },
                        {
                            icon = " ", -- " 󰊳 ",
                            desc = "Lazy",
                            group = "@property",
                            action = "Lazy",
                            key = "l",
                        },
                    },
                },
            })
        end,
    },
}
