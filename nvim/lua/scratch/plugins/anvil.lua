local function on_exit(code, title)
    if code == 0 then
        vim.notify(title .. " finished.", vim.log.levels.INFO)
    else
        vim.notify(title .. " failed.", vim.log.levels.ERROR)
        vim.cmd("copen | wincmd J")
    end
end

return {
    "reybits/anvil.nvim",
    lazy = true,
    keys = {
        {
            "<leader>ra",
            function()
                require("anvil").run("make android", function(code)
                    on_exit(code, "Android Release")
                end, { log_to_qf = true })
            end,
            desc = "Do 'make android'",
        },

        {
            "<leader>rA",
            function()
                require("anvil").run("make .android", function(code)
                    on_exit(code, "Android Debug")
                end, { log_to_qf = true })
            end,
            desc = "Do 'make .android'",
        },

        {
            "<leader>rb",
            function()
                require("anvil").run("make release", function(code)
                    on_exit(code, "Build Release")
                end, { log_to_qf = true })
            end,
            desc = "Do 'make release'",
        },

        {
            "<leader>rB",
            function()
                require("anvil").run("make .debug", function(code)
                    on_exit(code, "Build Debug")
                end, { log_to_qf = true })
            end,
            desc = "Do 'make .debug'",
        },

        {
            "<leader>rw",
            function()
                require("anvil").run("make web", function(code)
                    on_exit(code, "Web Release")
                end, { log_to_qf = true })
            end,
            desc = "Do 'make web'",
        },

        {
            "<leader>rW",
            function()
                require("anvil").run("make .web", function(code)
                    on_exit(code, "Web Debug")
                end, { log_to_qf = true })
            end,
            desc = "Do 'make .web'",
        },

        -- build resources
        {
            "<leader>rr",
            function()
                require("anvil").run("make resources", function(code)
                    on_exit(code, "Resources")
                end)
            end,
            desc = "Do 'make resources'",
        },

        -- build compile_commands.json
        {
            "<leader>rc",
            function()
                require("anvil").run("make build_compile_commands", function(code)
                    on_exit(code, "Compile Commands")
                    if code == 0 then
                        vim.cmd("LspRestart")
                    end
                end)
            end,
            desc = "Do 'make build_compile_commands'",
        },
    },
    cmd = {
        "Anvil",
    },
    opts = {},
}
