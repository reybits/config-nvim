return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup({
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                    -- disable = { "c", "cpp" },
                },
                autotag = {
                    enable = true,
                },
                -- ignore_install = {},
                auto_install = true,
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "cmake",
                    "make",
                    "css",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
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
