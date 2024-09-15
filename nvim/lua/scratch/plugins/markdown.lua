return {
    -- inline preview
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            -- render_modes = { "n", "v", "i", "c" },
            preset = "obsidian",
            sign = {
                enabled = false,
            },
            code = {
                style = "normal",
                border = "thick",
            },
            heading = {
                border = true,
                -- position = "inline",
            },
            quote = {
                repeat_linebreak = true,
            },
            pipe_table = {
                preset = "round",
                alignment_indicator = "┅",
            },
            win_options = {
                showbreak = { default = "", rendered = "  " },
                breakindent = { default = false, rendered = true },
                breakindentopt = { default = "", rendered = "" },
                conceallevel = {
                    default = vim.api.nvim_get_option_value("conceallevel", {}),
                    rendered = 3,
                },
                concealcursor = {
                    default = vim.api.nvim_get_option_value("concealcursor", {}),
                    rendered = "",
                },
            },
        },
    },

    -- browser preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
}
