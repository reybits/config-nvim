return {
    "stevearc/conform.nvim",
    dependencies = {
        "mason.nvim",
    },
    event = { "BufWritePre" },
    cmd = { "ConformInfo", "FormatEnable", "FormatDisable" },
    keys = {
        {
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
                java = { "astyle" },
                json = { "prettier" },
                lua = { "stylua" },
                objc = { "clang-format" },
                python = { "isort", "black" },
                sh = { "shfmt" },
                typescript = { "prettier" },
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
