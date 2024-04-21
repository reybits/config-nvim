return {
    "stevearc/conform.nvim",
    dependencies = {
        "mason.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
                css = { "prettier" },
                html = { "prettier" },
                javascript = { "prettier" },
                json = { "prettier" },
                lua = { "stylua" },
                objc = { "clang-format" },
                python = { "isort", "black" },
                sh = { "shfmt" },
                typescript = { "prettier" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>bf", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format buffer/range" })
    end,
}
