local exclude_filetypes = {
    "aerial",
    "alpha",
    "dashboard",
    "help",
    "lazy",
    "lazyterm",
    "mason",
    "neo-tree",
    "notify",
    "nvimtree",
    "toggleterm",
    "trouble",
}

return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            indent = {
                char = "│", -- "┋",
                tab_char = "│",
            },
            scope = { enabled = false },
            exclude = {
                filetypes = exclude_filetypes,
            },
        },
    },

    {
        "echasnovski/mini.indentscope",
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            -- Which character to use for drawing scope indicator
            symbol = "╎", -- "┋", "│",
            options = {
                -- Type of scope's border: which line(s) with smaller indent to
                -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
                border = "both",

                -- Whether to use cursor column when computing reference indent.
                -- Useful to see incremental scopes with horizontal cursor movements.
                indent_at_cursor = true,

                -- Whether to first check input line to be a border of adjacent scope.
                -- Use it if you want to place cursor on function header to get scope of
                -- its body.
                try_as_border = true,
            },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = exclude_filetypes,
                callback = function(args)
                    vim.b[args.buf].miniindentscope_disable = true
                end,
            })
        end,
    },
}
