return {
    "reybits/anvil.nvim",
    lazy = true,
    keys = {
        {
            "<leader>ra",
            function()
                require("anvil").run("make android", {
                    title = "Android Release",
                    log_to_qf = false,
                    close_on_success = true,
                })
            end,
            desc = "Do 'make android'",
        },

        {
            "<leader>rA",
            function()
                require("anvil").run("make .android", {
                    title = "Android Debug",
                    log_to_qf = false,
                    close_on_success = true,
                })
            end,
            desc = "Do 'make .android'",
        },

        {
            "<leader>rb",
            function()
                require("anvil").run("make release", {
                    title = "Build Release",
                    log_to_qf = false,
                    close_on_success = true,
                })
            end,
            desc = "Do 'make release'",
        },

        {
            "<leader>rB",
            function()
                require("anvil").run("make .debug", {
                    title = "Build Debug",
                    log_to_qf = false,
                    close_on_success = true,
                })
            end,
            desc = "Do 'make .debug'",
        },

        {
            "<leader>rw",
            function()
                require("anvil").run("make web", {
                    title = "Web Release",
                    log_to_qf = false,
                    close_on_success = true,
                })
            end,
            desc = "Do 'make web'",
        },

        {
            "<leader>rW",
            function()
                require("anvil").run("make .web", {
                    title = "Web Debug",
                    log_to_qf = false,
                    close_on_success = true,
                })
            end,
            desc = "Do 'make .web'",
        },

        -- build resources
        {
            "<leader>rr",
            function()
                require("anvil").run("make resources", {
                    title = "Resources",
                    log_to_qf = false,
                    close_on_success = true,
                })
            end,
            desc = "Do 'make resources'",
        },

        -- build compile_commands.json
        {
            "<leader>rc",
            function()
                require("anvil").run("make build_compile_commands", {
                    title = "Compile Commands",
                    log_to_qf = false,
                    close_on_success = true,
                    on_exit = function(code, o)
                        if code == 0 then
                            vim.notify(o.title .. " completed successfully.", vim.log.levels.INFO)
                            vim.cmd("LspRestart")
                        else
                            vim.notify(
                                o.title .. " failed with exit code: " .. code,
                                vim.log.levels.ERROR
                            )
                        end
                    end,
                })
            end,
            desc = "Do 'make build_compile_commands'",
        },
    },
    cmd = {
        "Anvil",
    },
    opts = {
        -- mode = "term", -- Use internal terminal to run commands.
    },
}
