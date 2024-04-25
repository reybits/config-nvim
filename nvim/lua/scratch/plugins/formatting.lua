return {
    "stevearc/conform.nvim",
    dependencies = {
        "mason.nvim",
    },
    event = { "BufWritePre" },
    cmd = { "ConformInfo", "FormatEnable", "FormatDisable" },
    keys = {
        {
            mode = { "n", "v" },
            "<leader>bf",
            function()
                -- require("conform").format({ async = true, lsp_fallback = true })
                require("conform").format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                })
            end,
            desc = "Format Buffer/Range",
        },
    },
    config = function()
        local conform = require("conform")

        conform.setup({
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
                python = { "isort", "black" },
                sh = { "shfmt" },
                typescript = { "prettier" },
                gml = { "gml" },
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
                if
                    vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat
                then
                    return
                end
                return {
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 500,
                }
            end,
        })

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
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
