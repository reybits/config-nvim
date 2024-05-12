return {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
        { "<leader>a", "<cmd>AerialToggle left<cr>", desc = "Toggle Areal" },
    },
    opts = {
        backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
        layout = {
            max_width = { 70, 0.4 },
            default_direction = "prefer_left",
        },
    },
    -- dependencies = {
    --     "nvim-treesitter/nvim-treesitter",
    --     "nvim-tree/nvim-web-devicons",
    -- },
}
