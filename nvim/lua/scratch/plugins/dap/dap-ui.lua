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
        config = function()
            vim.api.nvim_create_autocmd({ "FileType" }, {
                pattern = {
                    "dap-view",
                    "dap-view-term",
                    "dap-repl", -- dap-repl is set by `nvim-dap`
                },
                callback = function(args)
                    vim.opt_local.cc = ""
                    vim.opt_local.signcolumn = "no"
                    vim.opt_local.wrap = true
                    vim.keymap.set("n", "q", "<C-w>q", { buffer = args.buf })
                end,
            })
        end,
        opts = {
            switchbuf = "uselast,useopen",
            winbar = {
                controls = {
                    enabled = true,
                },
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
