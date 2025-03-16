return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    event = {
        "BufWinEnter",
    },
    -- stylua: ignore
    keys = {
        { "<leader>e", "<cmd>Neotree filesystem reveal toggle<cr>", desc = "Toggle File Explorer" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- { "3rd/image.nvim", opts = {} }, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
        sources = { "filesystem" },
        sort_case_insensitive = true,
        window = {
            position = "top",
            mappings = {
                ["<space>"] = false,
                ["w"] = false,
            },
        },
        filesystem = {
            filtered_items = {
                visible = true, -- when true, they will just be displayed differently than normal items
            },
        },
    },
}
