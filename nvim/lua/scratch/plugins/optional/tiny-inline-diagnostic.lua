return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require("tiny-inline-diagnostic").setup({
            preset = "powerline",
        })

        -- Disable Neovim's default virtual text diagnostics
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = false,
        })
    end,
}
