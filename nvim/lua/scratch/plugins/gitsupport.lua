return {
    -- best git wrapper for vim
    --[[
    "tpope/vim-fugitive",
    -- stylua: ignore
    keys = {
        { "<leader>gg", "<cmd>Git<cr>", desc = "Git Fugitive" },
        { "<leader>gb", "<cmd>Git blame<cr>", desc = "Toggle Git Blame" },
    },
    --]]

    -- clone of magit
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional
        "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
    -- stylua: ignore
    keys = {
        { "<leader>gG", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Neogit (cwd)" },
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit (project root)" },
    },
}
