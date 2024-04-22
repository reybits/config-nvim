return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
        "folke/trouble.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    -- stylua: ignore
    keys = {
        { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "[TSCP] Buffers List" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[TSCP] Buffers List" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "[TSCP] Find Recent Files" },
        { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "[TSCP] Find Files" },
        { "<leader>ff", function()
                require("telescope.builtin").find_files({
                    cwd = require("telescope.utils").buffer_dir(),
                })
            end, desc = "[TSCP] Find Files (cwd)" },

        -- add a keymap to browse plugin files
        { "<leader>fP", function()
                require("telescope.builtin").find_files({
                    cwd = require("lazy.core.config").options.root,
                })
            end, desc = "Find plugin file" },

        { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "[TSCP] Live Grep" },
        { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "[TSCP] Grep String" },

        { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "[TSCP] Find TODO/INFO/..." },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local trouble = require("trouble.providers.telescope")

        telescope.setup({
            defaults = {
                scroll_strategy = "limit",
                winblend = 20,
                layout_config = {
                    width = 0.96,
                    height = 0.96,
                },
                path_display = { "truncate" },
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
                },
                -- prompt_prefix = "| ",
                -- selection_caret = "* ",
                mappings = {
                    i = {
                        ["<c-c>"] = false,
                        ["<down>"] = false,
                        ["<up>"] = false,
                        ["<pageup>"] = false,
                        ["<pagedown>"] = false,
                        ["<esc>"] = actions.close,
                        ["<c-j>"] = actions.move_selection_next,
                        ["<c-k>"] = actions.move_selection_previous,
                        ["<c-n>"] = actions.cycle_history_next,
                        ["<c-p>"] = actions.cycle_history_prev,
                        ["<c-t>"] = trouble.open_with_trouble,
                    },
                },
            },
            pickers = {
                buffers = {
                    ignore_current_buffer = true,
                    sort_lastused = true,
                    sort_mru = true,
                },
            },
        })

        telescope.load_extension("fzf")
    end,
}
