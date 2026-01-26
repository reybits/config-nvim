return {
    --
    -- Nice UI, easy to use, but has some issues with winfixbuf.
    -- Thus, moved it to optional plugins.
    --
    "igorlfs/nvim-dap-view",
    dependencies = {
        "mfussenegger/nvim-dap",

        -- How to add support for disasm:
        -- https://igorlfs.github.io/nvim-dap-view/disassembly
        -- { "Jorenar/nvim-dap-disasm", opts = {} },
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
    keys = {
        { "<leader>du", "<cmd>DapViewToggle<cr>", desc = "Dap UI" },
    },
    config = function()
        require("dap-view").setup({
            switchbuf = "uselast,useopen",
            winbar = {
                controls = {
                    enabled = true,
                    buttons = {
                        "play",
                        "step_into",
                        "step_over",
                        "step_out",
                        "term_restart",
                    },
                    custom_buttons = {
                        -- Stop | Restart
                        -- Double click, middle click or click with a modifier disconnect instead of stopping
                        term_restart = {
                            render = function(session)
                                local group = session and "ControlTerminate" or "ControlRunLast"
                                local icon = session and "" or ""
                                return "%#NvimDapView" .. group .. "#" .. icon .. "%*"
                            end,
                            action = function(clicks, button, modifiers)
                                local dap = require("dap")
                                local alt = clicks > 1
                                    or button ~= "l"
                                    or modifiers:gsub(" ", "") ~= ""
                                if not dap.session() then
                                    dap.run_last()
                                elseif alt then
                                    dap.disconnect()
                                else
                                    dap.terminate()
                                end
                            end,
                        },
                    },
                },
            },
        })

        vim.api.nvim_create_autocmd({ "FileType" }, {
            pattern = {
                "dap-view",
                "dap-view-term",
                "dap-repl", -- dap-repl is set by `nvim-dap`
                "term_restart",
            },
            callback = function(args)
                vim.opt_local.cc = ""
                vim.opt_local.signcolumn = "no"
                vim.opt_local.wrap = true
                vim.keymap.set("n", "q", "<C-w>q", { buffer = args.buf })
            end,
        })
    end,
}
