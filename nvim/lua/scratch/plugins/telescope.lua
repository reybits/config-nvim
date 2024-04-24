return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
        "folke/trouble.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    -- stylua: ignore
    keys = {
        { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Buffers List" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers List" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find Recent Files" },
        { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>ff", function()
                require("telescope.builtin").find_files({
                    cwd = require("telescope.utils").buffer_dir(),
                })
            end, desc = "Find Files (cwd)" },


        -- add a keymap to browse plugin files
        { "<leader>fP", function()
                require("telescope.builtin").find_files({
                    cwd = require("lazy.core.config").options.root,
                })
            end, desc = "Find plugin file" },

        { "<leader>bs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Search Buffer" },

        { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        { "<leader>sG", function()
                require("telescope.builtin").live_grep({
                    cwd = require("telescope.utils").buffer_dir(),
                })
            end, desc = "Live Grep (cwd)" },

        { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
        { "<leader>sW", function()
                require("telescope.builtin").grep_string({
                    cwd = require("telescope.utils").buffer_dir(),
                })
            end, desc = "Grep String (cwd)" },

        { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Find TODO/INFO/..." },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local actions_layout = require("telescope.actions.layout")
        local trouble = require("trouble.providers.telescope")

        telescope.setup({
            defaults = {
                scroll_strategy = "limit",
                winblend = 20,
                layout_config = {
                    width = 0.96,
                    height = 0.96,
                    preview_cutoff = 120,
                },
                path_display = { "truncate" },
                prompt_prefix = "  ",
                selection_caret = "󰜴 ",
                initial_mode = "insert",
                color_devicons = true,
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
                        ["<m-p>"] = actions_layout.toggle_preview,
                    },
                },
            },
            pickers = {
                buffers = {
                    ignore_current_buffer = true,
                    sort_lastused = true,
                    sort_mru = true,
                    mappings = {
                        i = {
                            ["<c-d>"] = actions.delete_buffer,
                        },
                    },
                    previewer = false,
                },
                current_buffer_fuzzy_find = {
                    previewer = false,
                },
                live_grep = {
                    previewer = false,
                },
                grep_string = {
                    previewer = false,
                },
                colorscheme = {
                    enable_preview = true,
                },
            },
            extensions = {
                fzf = {
                    -- false will only do exact matching
                    fuzzy = true,
                    -- override the generic sorter
                    override_generic_sorter = true,
                    -- override the file sorter
                    override_file_sorter = true,
                    -- "smart_case" or "ignore_case" or "respect_case" the default case_mode is "smart_case"
                    case_mode = "smart_case",
                },
            },
        })

        telescope.load_extension("fzf")
    end,
}
