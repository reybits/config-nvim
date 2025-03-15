return {
    "folke/lazydev.nvim",
    lazy = true,
    ft = "lua", -- only load on lua files
    opts = {
        library = {
            -- It can also be a table with trigger words / mods
            -- Only load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },

            -- Load the wezterm types when the `wezterm` module is required
            -- Needs `justinsgithub/wezterm-types` to be installed
            { path = "wezterm-types", mods = { "wezterm" } },
        },
    },
}
