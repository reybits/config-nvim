return {
    "reybits/anvil.nvim",
    keys = {
        {
            "<leader>ra",
            function()
                require("anvil").run("make android", {
                    title = "Android Release",
                })
            end,
            desc = "Do 'make android'",
        },

        {
            "<leader>rA",
            function()
                require("anvil").run("make .android", {
                    title = "Android Debug",
                })
            end,
            desc = "Do 'make .android'",
        },

        {
            "<leader>rb",
            function()
                require("anvil").run("make release", {
                    title = "Build Release",
                })
            end,
            desc = "Do 'make release'",
        },

        {
            "<leader>rB",
            function()
                require("anvil").run("make .debug", {
                    title = "Build Debug",
                })
            end,
            desc = "Do 'make .debug'",
        },

        {
            "<leader>rw",
            function()
                require("anvil").run("make web", {
                    title = "Web Release",
                })
            end,
            desc = "Do 'make web'",
        },

        {
            "<leader>rW",
            function()
                require("anvil").run("make .web", {
                    title = "Web Debug",
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
                    on_exit = function(code, o)
                        if code == 0 then
                            vim.notify(o.title .. " completed successfully.", vim.log.levels.INFO)
                            if vim.lsp.inline_completion ~= nil then
                                vim.cmd("lsp restart")
                            else
                                vim.cmd("LspRestart")
                            end
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
        "AnvilStop",
    },
    opts = {
        -- mode = "term", -- Use internal terminal to run commands.
        log_to_qf = true,
        open_qf_on_success = false,
        open_qf_on_error = true,
        close_on_success = true,
        close_on_error = true,
    },
}
