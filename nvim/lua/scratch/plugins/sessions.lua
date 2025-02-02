return {
    {
        "echasnovski/mini.sessions",
        version = false,
        dependencies = "stevearc/dressing.nvim",
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
                        -- action = "Telescope find_files preview={hide_on_startup=true} cwd=",
                        action = "FzfLua files preview={hide_on_startup=true} cwd=",
                    },
                    mru = {
                        limit = 10,
                        icon = "", -- " ",
                        label = "Most Recent Files (current dir)",
                        cwd_only = true,
                    },
                    shortcut = {
                        {
                            icon = " ", -- " 󱉯 "
                            desc = "Sessions",
                            group = "Number", --"@property",
                            action = "SessionsList",
                            key = "s",
                        },
                        {
                            icon = " ", -- "󱉯  "
                            desc = "Restore",
                            group = "Number", --"@property",
                            action = "SessionReadLast",
                            key = "r",
                        },
                        {
                            icon = "󰡦 ", -- " 󰉺  ",
                            desc = "Files",
                            group = "Label",
                            -- action = "Telescope find_files",
                            action = "FzfLua files",
                            key = "f",
                        },
                        {
                            icon = "󰔠 ", -- "󱑍  ",
                            desc = "Recent",
                            group = "Label",
                            -- action = "Telescope oldfiles",
                            action = "FzfLua oldfiles",
                            key = "o",
                        },
                        {
                            icon = "󱘢 ", -- " ",
                            desc = "Grep",
                            group = "Label",
                            -- action = "Telescope live_grep",
                            action = "FzfLua live_grep",
                            key = "g",
                        },
                        -- {
                        --     icon = " ", -- " 󰊳 ",
                        --     desc = "Lazy",
                        --     group = "@property",
                        --     action = "Lazy",
                        --     key = "l",
                        -- },
                    },
                },
            })
        end,
    },
}
