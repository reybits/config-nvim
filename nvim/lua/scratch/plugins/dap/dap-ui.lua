return {
    -- How to add support for disasm:
    -- https://igorlfs.github.io/nvim-dap-view/disassembly
    -- {
    --     "Jorenar/nvim-dap-disasm",
    --     dependencies = {
    --         "igorlfs/nvim-dap-view",
    --     },
    --     opts = {},
    -- },

    {
        "igorlfs/nvim-dap-view",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        cmd = {
            "DapViewOpen",
            "DapViewClose",
            "DapViewToggle",
            "DapViewWatch",
            "DapViewJump",
            "DapViewShow",
            "DapViewNavigate",
        },
        -- stylua: ignore
        keys = {
            { "<leader>dd", "<cmd>DapViewToggle<cr>", desc = "Toggle Debug Panel" },
        },
        opts = {
            switchbuf = "uselast,useopen",
            winbar = {
                controls = { enabled = true },
            },
        },
    },

    --[[
    -- fancy UI for the debugger
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text", -- virtual text for the debugger
    },
    -- stylua: ignore
    keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
    config = function(_, opts)
        local dapui = require("dapui")
        dapui.setup(opts)

        local dap = require("dap")

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
        end
    end,
    --]]
}
