return {
    -- clone of magit
    "NeogitOrg/neogit",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional
        "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
    opts = {
        graph_style = "unicode",
    },
    -- stylua: ignore
    keys = {
        { "<leader>gG", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Neogit (cwd)" },
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit (project root)" },
    },
}
