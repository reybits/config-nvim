return {
    "b0o/incline.nvim",
    -- Optional: Lazy load Incline
    event = "VeryLazy",
    config = function()
        -- require("incline").setup()

        require("incline").setup({
            render = function(props)
                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                if filename == "" then
                    filename = "[No Name]"
                end

                local devicons = require("nvim-web-devicons")
                local ft_icon, ft_color = devicons.get_icon_color(filename)

                local get_mod_prop = function()
                    local mod_icon = ""
                    local mod_color = "white"
                    local mod_gui = "normal"
                    if vim.bo[props.buf].modified then
                        mod_icon = " ●"
                        mod_color = "#F05050"
                        mod_gui = "bold,italic"
                    end
                    return mod_icon, mod_color, mod_gui
                end

                local mod_icon, mod_color, mod_gui = get_mod_prop()

                return {
                    { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
                    {
                        filename .. mod_icon,
                        guifg = mod_color,
                        gui = mod_gui,
                    },
                }
            end,
            hide = {
                only_win = "count_ignored",
            },
            window = {
                margin = {
                    horizontal = 0,
                    vertical = 0,
                },
            },
        })
    end,
}
