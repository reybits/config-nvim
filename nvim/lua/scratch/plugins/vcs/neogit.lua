return {
    -- clone of magit
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional (personally I use gitsigns instead)
        -- "nvim-telescope/telescope.nvim", -- optional (personally I don't use it in this case)
    },
    cmd = {
        "Neogit",
        "NeogitCurrent",
        "NeogitLog",
        "NeogitLogCurrent",
    },
    -- stylua: ignore
    keys = {
        { "<leader>gG", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Neogit (cwd)" },
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit (project)" },
        { "<leader>gl", "<cmd>NeogitLog .<cr>", desc = "Neogit Log (project)" },
        { "<leader>gL", "<cmd>NeogitLog<cr>", desc = "Neogit Log (file)" },
    },
    opts = {
        graph_style = "unicode",
        disable_insert_on_commit = true,
    },
}
