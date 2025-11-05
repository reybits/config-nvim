return {
    "mfussenegger/nvim-dap",
    dependencies = {
        { -- virtual text for the debugger
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
        },
    },
    cmd = {
        -- Session management
        "DapContinue", -- Continue executing a paused session or start a new one
        "DapDisconnect", -- Disconnect from an active debugging session
        "DapNew", -- Start one or more new debug sessions
        "DapTerminate", -- Terminate the current session

        -- Stepping
        "DapRestartFrame", -- Restart the active sessions' current frame
        "DapStepInto", -- Step into the current expression
        "DapStepOut", -- Step out of the current scope
        "DapStepOver", -- Step over the current line
        "DapPause", -- Pause the current thread or pick a thread to pause

        -- REPL
        "DapEval", -- Create a new window & buffer to evaluate expressions
        "DapToggleRepl", -- Open or close the REPL

        -- Breakpoints
        "DapClearBreakpoints", -- Clear all breakpoints
        "DapToggleBreakpoint", -- Set or remove a breakpoint at the current line

        -- Diagnostics
        "DapSetLogLevel", -- Set the log level
        "DapShowLog", -- Show the session log in a split window

        "DapVirtualTextToggle",
    },
    -- stylua: ignore
    keys = {
        { "<leader>dd", function() require("dap").continue({ new = true }) end, desc = "Run & Debug" },

        { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },

        { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
        { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Continue to Cursor" },
        { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step Into" },
        { "<leader>do", "<cmd>DapStepOver<cr>", desc = "Step Over" },
        { "<leader>dO", "<cmd>DapStepOut<cr>", desc = "Step Out" },
        { "<leader>dp", "<cmd>DapPause<cr>", desc = "Pause" },
        { "<leader>dx", "<cmd>DapTerminate<cr>", desc = "Terminate" },

        -- { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
        -- { "<leader>dj", function() require("dap").down() end, desc = "Down" },
        -- { "<leader>dk", function() require("dap").up() end, desc = "Up" },

        -- { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
        -- { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end, desc = "Session" },
        -- { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },

        { "<leader>dv", "<cmd>DapVirtualTextToggle<cr>", desc = "Toggle Virtual Text" },
    },
    config = function()
        local dap = require("dap")

        -- codelldb v1.11.0 and later
        dap.adapters.codelldb = {
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",

            -- On windows you may have to uncomment this:
            -- detached = false,
        }

        -- vim.api.nvim_set_hl(
        --     0,
        --     "DapStoppedLine",
        --     { default = true, link = "Visual" }
        -- )

        local helpers = require("scratch.core.helpers")

        for name, sign in pairs(helpers.icons.dap) do
            vim.fn.sign_define("Dap" .. name, {
                text = sign[1],
                texthl = sign[2],
                linehl = sign[3],
                numhl = sign[3],
            })
        end
    end,
}
