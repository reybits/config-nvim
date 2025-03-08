return {
    "nvim-tree/nvim-tree.lua",
    lazy = true,
    event = {
        "BufWinEnter",
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    -- stylua: ignore
    keys = {
        { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle File Explorer" },
    },
    config = function()
        local nvimtree = require("nvim-tree")

        --- recommended settings from nvim-tree docs
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        nvimtree.setup({
            view = {
                width = 40,
            },
            renderer = {
                indent_markers = {
                    enable = true,
                },
            },
            actions = {
                open_file = {
                    window_picker = {
                        -- disable "Pick window" message in splits
                        enable = false,
                    },
                },
            },
            filters = {
                git_ignored = false,
                dotfiles = true,
            },
        })
    end,
}
