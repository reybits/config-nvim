return {
    -- clone of magit
    "NeogitOrg/neogit",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        -- "sindrets/diffview.nvim", -- optional (personally I use gitsigns instead)
        -- "nvim-telescope/telescope.nvim", -- optional (personally I don't use it in this case)
    },
    opts = {
        graph_style = "unicode",
    },
    -- stylua: ignore
    keys = {
        { "<leader>gG", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Neogit (cwd)" },
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit (project)" },
        { "<leader>gl", "<cmd>Neogit log<cr>", desc = "Neogit Log (project)" },
    },
}
