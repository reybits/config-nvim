require("telescope").setup({
    defaults = {
        -- prompt_prefix = "| ",
        selection_caret = "* ",
        -- path_display = { "smart" },
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-n>"] = "cycle_history_next",
                ["<C-p>"] = "cycle_history_prev",
            },
            n = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
                ["<C-n>"] = "cycle_history_next",
                ["<C-p>"] = "cycle_history_prev",
            },
        },
    },
    pickers = {
        oldfiles = {
            theme = "dropdown",
        },
        buffers = {
            theme = "dropdown",
        },
        current_buffer_fuzzy_find = {
            theme = "dropdown",
            previewer = false,
        },
        git_files = {
            theme = "dropdown",
        },
        find_files = {
            theme = "dropdown",
        },
        help_tags = {
            theme = "dropdown",
        },
        grep_string = {
            theme = "dropdown",
        },
        live_grep = {
            theme = "dropdown",
        },
        diagnostics = {
            theme = "dropdown",
        },
        lsp_references = {
            theme = "dropdown",
        },
        lsp_document_symbols = {
            theme = "dropdown",
        },
        lsp_dynamic_workspace_symbols = {
            theme = "dropdown",
        },
    },
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Existing buffers", silent = true })
vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Recently opened files", silent = true })
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer", silent = true })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles", silent = true })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles", silent = true })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp", silent = true })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord", silent = true })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep", silent = true })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics", silent = true })

