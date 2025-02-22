return {
    "mfussenegger/nvim-lint",
    cmd = {
        "LinterHide",
    },
    keys = {
        {
            mode = "n",
            "<leader>cl",
            function()
                require("lint").try_lint()
            end,
            desc = "Run Code Linter",
        },
    },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            -- c = { "cpplint" },
            -- cpp = { "cpplint" },
            bash = { "shellcheck" },
            lua = { "luacheck" },
            javascript = { "quick_lint_js" },
            typecript = { "quick_lint_js" },
        }

        vim.api.nvim_create_user_command("LinterHide", function()
            vim.diagnostic.reset(nil, 0)
        end, {
            desc = "Hide Linger Diagnostics",
        })
    end,
}
