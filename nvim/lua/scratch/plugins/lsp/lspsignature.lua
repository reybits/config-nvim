return {
    "ray-x/lsp_signature.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    config = function(_, opts)
        require("lsp_signature").setup(opts)
    end,
}
