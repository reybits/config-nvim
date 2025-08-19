return {
    "mfussenegger/nvim-dap",

    -- stylua: ignore
    keys = {
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
        { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end, desc = "Down" },
        { "<leader>dk", function() require("dap").up() end, desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
        { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
        { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end, desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
    config = function()
        local dap = require("dap")

        if not dap.adapters["codelldb"] then
            dap.adapters["codelldb"] = {
                name = "codelldb server",
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                    args = { "--port", "${port}" },
                },
            }
        end

        -- local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
        -- dap.adapters.executable = {
        --     type = "executable",
        --     command = codelldb_path,
        --     name = "lldb1",
        --     host = "127.0.0.1",
        --     port = 13000,
        -- }
        -- dap.adapters.codelldb = {
        --     name = "codelldb server",
        --     type = "server",
        --     port = "${port}",
        --     executable = {
        --         command = codelldb_path,
        --         args = { "--port", "${port}" },
        --     },
        -- }

        -- vim.api.nvim_set_hl(
        --     0,
        --     "DapStoppedLine",
        --     { default = true, link = "Visual" }
        -- )

        -- local helpers = require("scratch.core.helpers")

        -- INFO: Deprecated method
        -- for name, sign in pairs(helpers.icons.dap) do
        --     vim.fn.sign_define("Dap" .. name, {
        --         text = sign[1],
        --         texthl = sign[2],
        --         linehl = sign[3],
        --         numhl = sign[3],
        --     })
        -- end

        --[[
        -- TODO: Research and implement the correct setup for diagnostics in DAP
        local signs = { text = {}, linehl = {}, numhl = {} }
        for type, icon in pairs(helpers.icons.dap) do
            local key = string.upper(type)
            signs.text[vim.diagnostic.severity[key] ] = icon[1]
            signs.texthl[vim.diagnostic.severity[key] ] = "Dap" .. icon[2]
            signs.linehl[vim.diagnostic.severity[key] ] = "Dap" .. icon[3]
        end
        vim.diagnostic.config({
            signs = signs,
        })
        --]]
    end,
}
