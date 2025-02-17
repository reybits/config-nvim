return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
    event = { "BufWritePre" },
    cmd = { "ConformInfo", "FormatEnable", "FormatDisable", "FormatBuffer" },
    keys = {
        {
            mode = { "n", "v" },
            "<leader>bf",
            "<cmd>FormatBuffer<cr>",
            desc = "Format Buffer/Range",
        },
    },
    config = function()
        local conform = require("conform")

        local formatOpts = function()
            return {
                -- async = true,
                lsp_format = "fallback",
                quiet = true,
            }
            -- FIXME: Error message not supported anymore?
            --
            --[[
            , function(err)
                if err then
                    local helpers = require("scratch.core.helpers")
                    local result = helpers.split_to_strings(err, 60)

                    -- display error message in reverse order
                    -- because fidget prints it from bottom to top
                    for i = #result, 1, -1 do
                        local msg = result[i]

                        -- left justify
                        local len = msg:len()
                        if len < 60 then
                            msg = msg .. string.rep(" ", 60 - len)
                        end

                        vim.notify(msg, vim.log.levels.ERROR)
                    end
                end
            end
            --]]
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
            format_on_save = function(bufnr)
                -- Disable with a global or buffer-local variable
                -- stylua: ignore
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end

                return formatOpts()
            end,
        })

        vim.api.nvim_create_user_command("FormatBuffer", function()
            conform.format(formatOpts())
        end, {
            desc = "Format Buffer/Range",
        })

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting globaly
                vim.g.disable_autoformat = true
            else
                vim.b.disable_autoformat = true
            end
        end, {
            desc = "Disable Autoformat-on-save",
            bang = true,
        })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Enable Autoformat-on-save",
        })
    end,
}
