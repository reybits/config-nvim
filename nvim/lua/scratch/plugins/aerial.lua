return {
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>co", "<cmd>AerialToggle left<cr>", desc = "Code Outline" },
    },
    opts = {
        backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
    },
}
