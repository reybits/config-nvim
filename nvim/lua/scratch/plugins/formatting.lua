local ToggleOption = require("scratch.core.toggleopt")

local toggle_autoformat = ToggleOption:new("<leader>of", function(state)
    vim.g.autoformat_toggle = state
end, "Autoformat", vim.g.autoformat_toggle or true)

return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
    event = {
        "BufWritePre",
    },
    cmd = {
        "ConformInfo",
        "FormatEnable",
        "FormatDisable",
        "FormatBuffer",
    },
    keys = {
        {
            mode = { "n", "v" },
            "<leader>bf",
            "<cmd>FormatBuffer<cr>",
            desc = "Format Buffer/Range",
        },
        {
            mode = "n",
            toggle_autoformat:getMapping(),
            toggle_autoformat:getToggleFunc(),
            desc = toggle_autoformat:getCurrentDescription(),
        },
    },
    config = function()
        local conform = require("conform")

        local formatOpts = function()
            return {
                lsp_format = "fallback",
                async = false,
                quiet = true,
            }, function(err)
                if err then
                    vim.notify(err, vim.log.levels.ERROR)
                end
            end
        end

        conform.setup({
            notify_on_error = true,
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
                css = { "prettier" },
                html = { "prettier" },
                javascript = { "prettier" },
                java = { "java" },
                json = { "prettier" },
                lua = { "stylua" },
                objc = { "clang-format" },
                -- python = { "isort", "black" },
                sh = { "shfmt" },
                typescript = { "prettier" },
                gml = { "gml" },

                ["_"] = { "trim_whitespace" },
            },
            formatters = {
                java = {
                    command = "astyle",
                    inherit = false,
                    args = {
                        "--style=java",
                        "--indent=spaces=4",
                        "--convert-tabs",
                        "--attach-closing-while",
                        "--indent-col1-comments",
                        "--pad-oper",
                        "--pad-comma",
                        "--pad-header",
                        "--unpad-brackets",
                        "--unpad-paren",
                        "--squeeze-lines=1",
                        "--squeeze-ws",
                        "--break-one-line-headers",
                        "--add-braces",
                        "--attach-return-type",
                        -- "--max-code-length=100",
                        "--break-after-logical",
                        "--preserve-date",
                        "--quiet",
                        "--lineend=linux",
                    },
                },
                gml = {
                    command = "astyle",
                    inherit = false,
                    args = {
                        "--style=break",
                        "--mode=js",
                        "--indent=spaces=4",
                        "--convert-tabs",
                        "--attach-closing-while",
                        "--indent-after-parens",
                        "--indent-col1-comments",
                        "--pad-oper",
                        "--pad-comma",
                        "--pad-header",
                        "--unpad-brackets",
                        "--unpad-paren",
                        -- "--delete-empty-lines", -- ?
                        "--squeeze-lines=1",
                        "--squeeze-ws", -- ?
                        "--break-closing-braces",
                        "--break-one-line-headers",
                        "--add-braces",
                        "--max-code-length=100",
                        "--break-after-logical",
                        "--preserve-date",
                        "--quiet",
                        "--lineend=windows", -- default for GameMaker
                    },
                },
            },
            format_on_save = function()
                if toggle_autoformat:getState() == false then
                    return nil
                end

                return { formatOpts() }
            end,
        })

        vim.api.nvim_create_user_command("FormatBuffer", function()
            conform.format(formatOpts())
        end, {
            desc = "Format Buffer/Range",
        })

        vim.api.nvim_create_user_command("FormatDisable", function()
            toggle_autoformat:setState(false)
        end, {
            desc = "Disable Autoformat-on-save",
        })

        vim.api.nvim_create_user_command("FormatEnable", function()
            toggle_autoformat:setState(true)
        end, {
            desc = "Enable Autoformat-on-save",
        })
    end,
}
