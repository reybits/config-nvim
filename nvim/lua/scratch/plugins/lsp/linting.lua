return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            -- c = { "cpplint" },
            -- cpp = { "cpplint" },
            bash = { "shellcheck" },
            -- lua = { "luacheck" },
            javascript = { "quick_lint_js" },
            typecript = { "quick_lint_js" },
        }

        -- local lint_group = vim.api.nvim_create_augroup("lint", { clear = true })
        -- vim.api.nvim_create_autocmd(
        --     { "BufEnter", "BufWritePost", "InsertLeave" },
        --     {
        --         group = lint_group,
        --         callback = function()
        --             lint.try_lint()
        --         end,
        --     }
        -- )

        vim.keymap.set("n", "<leader>cl", function()
            lint.try_lint()
        end, { desc = "Run Code Linter" })
    end,
}
