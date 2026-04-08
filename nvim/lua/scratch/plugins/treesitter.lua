return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        init = function()
            -- Disable the buggy plugin code; only use query files
            -- (highlights, injections, folds, etc.)
            vim.g.loaded_nvim_treesitter = 1
        end,
    },

    {
        "lewis6991/ts-install.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        lazy = false,
        config = function()
            require("ts-install").setup({
                ensure_install = {
                    "bash",
                    "c",
                    "cpp",
                    "cmake",
                    "make",
                    "css",
                    "html",
                    "javascript",
                    "java",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "tsx",
                    "typescript",
                    "gitignore",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                auto_install = false,
            })

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("scratch_treesitter", { clear = true }),
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
    },
}
