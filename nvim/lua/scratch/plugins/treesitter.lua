return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        config = function()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup({
                highlight = {
                    enable = true,
                },
                -- Indentation based on treesitter for the = operator.
                -- This is an experimental feature.
                -- Therefore I disable it at all.
                indent = {
                    enable = false,
                    -- disable = { "c", "cpp" },
                },
                ignore_install = {},
                modules = {},
                auto_install = true,
                sync_install = false,
                ensure_installed = {
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
            })
        end,
    },

    --[[
    {
        "nvim-treesitter/nvim-treesitter-context",
        keys = {
            { "<leader>uc", "<cmd>TSContextToggle<cr>", desc = "Toggle TS Context" },
        },
        opts = {
            enable = false,
            max_lines = 2,
            multiline_threshold = 1, -- Maximum number of lines to show for a single context
        },
    },
    --]]
}
