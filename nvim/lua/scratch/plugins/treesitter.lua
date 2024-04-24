return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        dependencies = {
            "nvim-treesitter/playground",
        },
        config = function()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup({
                highlight = {
                    enable = false,
                },
                indent = {
                    enable = false,
                    -- disable = { "c", "cpp" },
                },
                autotag = {
                    enable = true,
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

            local treesitter_cfg = require("nvim-treesitter.configs")
            treesitter_cfg.setup({
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = "o",
                        toggle_hl_groups = "i",
                        toggle_injected_languages = "t",
                        toggle_anonymous_nodes = "a",
                        toggle_language_display = "I",
                        focus_language = "f",
                        unfocus_language = "F",
                        update = "R",
                        goto_node = "<cr>",
                        show_help = "?",
                    },
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
